module S=String
module H=Hashtbl
let c i s l = S.sub i s l
type 'a m = string -> string * ('a, unit) result
let ret v = (fun i -> i, Ok v)
let fail err = (fun i -> i, Error ())
let ( >>= ) p f = (fun i -> match p i with | i', Ok x -> (f x) i' | i', Error _ -> i', Error ())
let any = (fun i -> let n = S.length i in try c i 1 (n - 1), Ok (S.get i 0) with | _ -> i, Error ())
let peek = (fun i -> try i, Ok (S.get i 0) with _ -> i, Error ())
let s f = peek >>= fun c -> if f c then any else fail ""
let char c = s (fun x -> x = c)
let lower = s (fun x -> 'a' <= x && x <= 'z')
let ( <|> ) p1 p2 = (fun i -> let i', res = p1 i in match res with | Ok x -> i', Ok x | Error _ -> p2 i)
let ( >>| ) m f = m >>= fun x -> ret (f x)
let ( <$> ) f m = m >>| f
let ( <*> ) f m = f >>= fun f -> m >>| f
let ( *> ) p1 p2 = p1 >>= fun _ -> p2
let ( <* ) p1 p2 = p1 >>= fun x -> p2 >>| fun _ -> x
let l2 f m1 m2 = f <$> m1 <*> m2
let fix f = let rec p = lazy (f r) and r = (fun i -> (Lazy.force p) i) in r
let pair p = l2 (fun e1 e2 -> e1, e2) p p
let parens p = char '(' *> p <* char ')'
let chain e op = let rec go acc = l2 (fun f x -> f acc x) op e >>= go <|> ret acc in e >>= fun init -> go init
type e = | Var of int | And of e * e | Or of e * e | Xor of e * e | Neg of e
let var_of x = Var x
let id = ref (-1)
let gen () = incr id; !id
let reset () = id := -1
let var ~occur = lower >>| fun var -> match H.find_opt occur var with | Some id -> var_of id | None -> let id = gen () in H.add occur var id; var_of id
let and_ = char '&' *> ret (fun x y -> And(x,y))
let or_ = char '|' *> ret (fun x y -> Or(x,y))
let xor = char '^' *> ret (fun x y -> Xor(x, y))
let neg p = char '~' *> (p >>| (fun x -> Neg x))
let e ~occur = fix (fun e -> let factor = fix (fun factor -> neg factor <|> parens e <|> var ~occur) in let t0 = chain factor and_ in let t1 = chain t0 xor in chain t1 or_)
let rmb s = Seq.filter (fun c -> c <> ' ') (S.to_seq s) |> S.of_seq
let exprs s = let occur = H.create 26 in reset (); match (pair (e ~occur)) (rmb s) with | _, Ok r -> r, H.length occur
let eval ~f exp = let rec aux = function | Var x -> f x | Or (e1, e2) -> aux e1 || aux e2 | And (e1, e2) -> aux e1 && aux e2 | Xor (e1, e2) -> let v1 = aux e1 in let v2 = aux e2 in ((not v1) && v2) || (v1 && not v2) | Neg e -> not (aux e) in aux exp
let check e1 e2 n = let f x = n land (1 lsl x) = 0 in let v1 = eval ~f e1 in let v2 = eval ~f e2 in v1 = v2
let cases n = let rec gen v acc = if v >= n then acc else gen (v + 1) (v :: acc) in gen 0 []
let solve s case = let (e1, e2), total = exprs s in let res = List.for_all (fun n -> check e1 e2 n) (cases (1 lsl total)) in Printf.printf "Data set %d: %s\n" case (if res then "Equivalent" else "Different")
let main () = let total = read_int () in for case = 1 to total do let i = read_line () in solve i case done
let () = main ()
