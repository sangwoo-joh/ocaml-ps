#!/bin/bash
PNUM=$1
ocamlc -o sol-$PNUM $PNUM/main.ml
