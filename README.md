# ocaml-ps

 [Problem solving](https://www.acmicpc.net/) with OCaml!

## Reference

 - [Baekjoon Language](https://www.acmicpc.net/help/language)

## How to build

 - Make file as `p<problem-number>.ml`. Note that it must start with
   **p**. (due to OCaml's [module name
   policy](https://caml.inria.fr/pub/docs/manual-ocaml-4.07/names.html#module-name),
   a filename cannot start with a bare number)
 - `./build.sh <problem-number>` will make `<problem-number>.bc`
   byte-code compiled executable.
