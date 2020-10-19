open Core_bench

let str1 = "abcdefgasdfwef1029839pquij%kj1h23ouhdsf"

let int1 = 10_82938

let float1 = 1882.8323

let benches =
  Bench.make_command
    [
      Bench.Test.create ~name:"print_string" (fun () ->
          print_string str1;
          print_char ' ';
          print_int int1;
          print_char ' ';
          print_float float1;
          print_newline ());
      Bench.Test.create ~name:"Format.printf" (fun () ->
          Format.printf "%s %d %f\n" str1 int1 float1);
      Bench.Test.create ~name:"Printf.printf" (fun () ->
          Printf.printf "%s %d %f\n" str1 int1 float1);
    ]


let () = Core.Command.run benches
