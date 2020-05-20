#!/bin/bash
set -e -u

function help
{
  cat <<EOF
Usage: $_ [option]

Options
  help            Show this message
  PROBLEM_NUMBER  Build PROBLEM_NUMBER.ml as sol-PROBLEM_NUMBER
  clean           Clean directory
EOF
}

function clean
{
  rm *.bc *.cm* 2>/dev/null
}

PNUM=

while [[ $# -gt 0 ]]
do
  key="$1"

  case $key in
    -h|--help|help|h|--h|-help)
      help
      exit 0
      ;;
    clean)
      clean
      exit 0
      ;;
    [0-9]*)
      PNUM=$key
      shift
      ;;
    *)
      help
      exit 1
      ;;
  esac
done

echo "Build $PNUM"

if [ ! -e p"$PNUM".ml ]; then
  if [ "$PNUM" -lt 1000 ]; then
    echo "Invalid problem number. (< 1000)"
    exit 1
  else
    echo "You didn't solve problem $PNUM yet!"
    echo "Try to solve!: https://www.acmicpc.net/problem/$PNUM"
    exit 1
  fi
fi

# build command: https://www.acmicpc.net/help/language
ocamlc -o "$PNUM".bc p"$PNUM".ml
rm *.cm* 2>/dev/null

echo "Checkout $PNUM.bc"
