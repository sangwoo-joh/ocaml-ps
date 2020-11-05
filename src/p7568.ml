type physical = { weight : int; height : int }

type physical_comparison = Stronger | Weaker | Dont_know | Me

let compare_physical ph1 ph2 =
  if ph1.height = ph2.height && ph1.weight = ph2.weight then Me
  else if ph1.height > ph2.height && ph1.weight > ph2.weight then Stronger
  else if ph2.height < ph2.height && ph1.weight < ph2.weight then Weaker
  else Dont_know


let rank_of me all =
  succ
    (List.fold_left
       (fun count you ->
         match compare_physical you me with
         | Stronger -> count + 1
         | Weaker | Me | Dont_know -> count)
       0 all)


let () =
  Scanf.scanf "%d " (fun total ->
      let all : physical list ref = ref [] in
      for _ = 1 to total do
        all :=
          Scanf.scanf "%d %d " (fun weight height -> { weight; height }) :: !all
      done;
      let all = List.rev !all in
      List.iter (fun p -> Printf.printf "%d " (rank_of p all)) all)
