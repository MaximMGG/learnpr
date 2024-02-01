#! /bin/sh



g++ loops.cpp -g -DOLD_STR
echo "Old string method"
time ./a.out
g++ loops.cpp -g -DNEW_STR
echo "New string method"
time ./a.out
