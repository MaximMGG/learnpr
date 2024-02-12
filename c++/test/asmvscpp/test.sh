#! /bin/sh
g++ oo.cpp -DSUM -o sum
echo "sum test"
time ./sum
g++ oo.cpp  sum.o -DSUM2 -o sum2
echo "sum2 test"
time ./sum2
gcc oo.c -DSUM -o sumc
echo "sumc test"
time ./sumc
gcc oo.c sum.o -DSUM2 -o sum2c
echo "sum2c test"
time ./sum2c
