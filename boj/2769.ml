type input = string

let consume (input : input) : input * char =
  let n = String.length input in
  String.sub input 1 (n - 1), String.get input 0
;;

type 'a parser = { run : input -> input * ('a, string) result }

(** [return v] creates a parser that will always succeed and return [v] *)
let return (v : 'a) : 'a parser = { run = (fun input -> input, Ok v) }

(** [fail msg] creates a parser that will always fail with the error
   message [msg] *)
let fail (err : string) : 'a parser = { run = (fun input -> input, Error err) }

(** [bind p f] or [p >>= f] creates a parser that will run [p], pass
   its result to [f], run the parser that [f] produces, and return its
   result.  *)
let bind (p : 'a parser) (f : 'a -> 'b parser) : 'b parser =
  { run =
      (fun input ->
        match p.run input with
        | input', Ok x -> (f x).run input'
        | input', Error err -> input', Error err)
  }
;;

let ( >>= ) = bind

(** [p <|> q] runs [p] and returns the result if succeeds. If [p]
   fails then the input will be reset and [q] will run instead. *)
let ( <|> ) (p1 : 'a parser) (p2 : 'a parser) : 'a parser =
  { run =
      (fun input ->
        let input', result = p1.run input in
        match result with
        | Ok x -> input', Ok x
        | Error _ -> p2.run input)
  }
;;

(** [p >>| f] creates a parser that will run [p], and if it succeeds
   with result [v], will return [f v] *)
let ( >>| ) m f = m >>= fun x -> return (f x)

let ( <$> ) f m = m >>| f
let ( <*> ) f m = f >>= fun f -> m >>| f

(** [p *> q] runs [p], discards its result and then run [q], and
   return its result. *)
let ( *> ) p1 p2 = p1 >>= fun _ -> p2

(** [p <* q] runs [p], then runs [q], discards its result, and returns
   the result of [p]. *)
let ( <* ) p1 p2 = p1 >>= fun x -> p2 >>| fun _ -> x

(** The [liftn] family of functions promote functions to the parser
   monad. For any of these functions, the following equivalence holds:
   [liftn f p1 ... pn = f <$> p1 <*> ... <*> pn ].  *)
let lift = ( >>| )

let lift2 f m1 m2 = f <$> m1 <*> m2
let lift3 f m1 m2 m3 = f <$> m1 <*> m2 <*> m3
let lift4 f m1 m2 m3 m4 = f <$> m1 <*> m2 <*> m3 <*> m4

let fix (f : 'a parser -> 'a parser) : 'a parser =
  let rec p = lazy (f r)
  and r = { run = (fun input -> (Lazy.force p).run input) } in
  r
;;

let any_char : char parser =
  { run =
      (fun input ->
        try
          let input', char = consume input in
          input', Ok char
        with
        | Invalid_argument _ -> input, Error "no char")
  }
;;

let peek_char : char parser =
  { run =
      (fun input ->
        try input, Ok (String.get input 0) with
        | Invalid_argument _ -> input, Error "no char")
  }
;;

let satisfy (f : char -> bool) : char parser =
  peek_char >>= fun c -> if f c then any_char else fail "not satisfied"
;;

let char (c : char) : char parser = satisfy (fun x -> x = c)
let lower : char parser = satisfy (fun x -> 'a' <= x && x <= 'z')
let upper : char parser = satisfy (fun x -> 'A' <= x && x <= 'Z')
let digit : char parser = satisfy (fun x -> '0' <= x && x <= '9')
let pair p = lift2 (fun e1 e2 -> e1, e2) p p
let parens p = char '(' *> p <* char ')'

let chain expr op =
  let rec further acc =
    lift2 (fun constructor x -> constructor acc x) op expr
    >>= further
    <|> return acc
  in
  expr >>= fun init -> further init
;;

(** Example of boolean expression *)
type expr =
  | Variable of int
  | And of expr * expr
  | Or of expr * expr
  | Xor of expr * expr
  | Neg of expr

let var_of x = Variable x
let and_of x y = And (x, y)
let or_of x y = Or (x, y)
let xor_of x y = Xor (x, y)
let neg_of x = Neg x

(* parsers *)
let id = ref (-1)

let get_id () =
  incr id;
  !id
;;

let reset_id () = id := -1

let var ~occur =
  lower
  >>| fun var ->
  match Hashtbl.find_opt occur var with
  | Some id -> var_of id
  | None ->
    let id = get_id () in
    Hashtbl.add occur var id;
    var_of id
;;

let and_ = char '&' *> return and_of
let or_ = char '|' *> return or_of
let xor = char '^' *> return xor_of
let neg p = char '~' *> (p >>| neg_of)

(**
   Precedence: ~ > & > ^ > |
            not > and > xor > or
   Boolean expression parser.
   EXPR := TERM0 or TERM0
         | TERM0

   TERM0 := TERM1 xor TERM1
          | TERM1

   TERM1 := FACTOR and FACTOR
          | FACTOR

   FACTOR := VAR
           | ( EXPR )
           | not FACTOR
*)
let expr ~occur : expr parser =
  fix (fun (expr : expr parser) ->
    let factor =
      fix (fun factor -> neg factor <|> parens expr <|> var ~occur)
    in
    let term0 = chain factor and_ in
    let term1 = chain term0 xor in
    chain term1 or_)
;;

let remove_blanks s =
  Seq.filter (fun c -> c <> ' ') (String.to_seq s) |> String.of_seq
;;

let parse_exprs s =
  let occur = Hashtbl.create 26 in
  reset_id ();
  match (pair (expr ~occur)).run (remove_blanks s) with
  | _, Ok r -> r, Hashtbl.length occur
  | _, Error msg -> failwith msg
;;

let eval ~f exp =
  let rec aux = function
    | Variable x -> f x
    | Or (e1, e2) -> aux e1 || aux e2
    | And (e1, e2) -> aux e1 && aux e2
    | Xor (e1, e2) ->
      let v1 = aux e1 in
      let v2 = aux e2 in
      ((not v1) && v2) || (v1 && not v2)
    | Neg e -> not (aux e)
  in
  aux exp
;;

let check e1 e2 n =
  let f x = n land (1 lsl x) = 0 in
  let v1 = eval ~f e1 in
  let v2 = eval ~f e2 in
  v1 = v2
;;

let gen_cases n =
  let rec gen v acc = if v >= n then acc else gen (v + 1) (v :: acc) in
  gen 0 []
;;

let solve s case =
  let (e1, e2), total = parse_exprs s in
  let res = List.for_all (fun n -> check e1 e2 n) (gen_cases (1 lsl total)) in
  Printf.printf
    "Data set %d: %s\n"
    case
    (if res then "Equivalent" else "Different")
;;

let main () =
  let total_case = read_int () in
  for case = 1 to total_case do
    let input = read_line () in
    solve input case
  done
;;

let () = main ()
