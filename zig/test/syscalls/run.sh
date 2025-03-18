#!/bin/sh

echo $1

echo "Print lines C" > print.txt
./print_c $1 | tail -n 2 >> print.txt
echo "Print lines in Zig C" >> print.txt
./args_print $1 | tail -n 2 >> print.txt
echo "Print lines in Zig" >> print.txt
./args_print2 $1 | tail -n 2 >> print.txt

cat print.txt

