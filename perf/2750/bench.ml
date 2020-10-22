open Core_bench

let tc_gen () =
  (* total 1000 numbers with [-1000, 1000]*)
  Random.self_init ();
  let gen () = string_of_int (Random.int 2000 - 1000) in
  let gen_list n =
    let rec aux n acc = if n = 0 then acc else aux (n - 1) (gen () :: acc) in
    aux n []
  in
  let n = 1000 in
  String.concat "\n" (string_of_int n :: gen_list n)


let sort_list input =
  let in_chan = Scanf.Scanning.from_string input in
  Scanf.bscanf in_chan "%d " (fun total ->
      let nums = ref [] in
      for _ = 1 to total do
        Scanf.bscanf in_chan "%d " (fun n -> nums := n :: !nums)
      done;
      let sorted = List.sort compare !nums in
      List.iter (Printf.printf "%d\n") sorted)


let sort_array input =
  let in_chan = Scanf.Scanning.from_string input in
  Scanf.bscanf in_chan "%d " (fun total ->
      let nums = Array.make total 0 in
      for i = 0 to total - 1 do
        Scanf.bscanf in_chan "%d " (fun n -> nums.(i) <- n)
      done;
      Array.sort compare nums;
      Array.iter (Printf.printf "%d\n") nums)


let benches =
  let input = tc_gen () in
  Bench.make_command
    [
      Bench.Test.create ~name:"Sort List" (fun () -> sort_list input);
      Bench.Test.create ~name:"Sort Array" (fun () -> sort_array input);
    ]


let () = Core.Command.run benches
