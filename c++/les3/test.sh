#! /bin/sh

g++ arr.cpp -DDYN_ARR
echo "Dynamyc arr test"
time ./a.out
g++ arr.cpp -DOLD_ARR
echo "Old arr test"
time ./a.out
g++ arr.cpp -DNEW_ARR
echo "New arr test"
time ./a.out
g++ arr.cpp -DVECTOR
echo "Vector test"
time ./a.out
