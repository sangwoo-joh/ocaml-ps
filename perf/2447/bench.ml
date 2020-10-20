open Core_bench

let all_input f =
  for e = 1 to 7 do
    let input = int_of_float (3. ** float_of_int e) in
    f input
  done


let benches =
  Bench.make_command
    [
      Bench.Test.create ~name:"Recursive by construction" (fun () -> all_input Sol1.print_star);
      Bench.Test.create ~name:"Recursive by destruction" (fun () -> all_input Sol3.print_star);
      Bench.Test.create ~name:"Recursive by list" (fun () -> all_input Sol2.print_star);
    ]


let () = Core.Command.run benches
