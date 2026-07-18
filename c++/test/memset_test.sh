#! /bin/bash


g++ memset_memset_test.cpp -o memset_test -O2
g++ memset_while_test.cpp -o while_test -O2


echo MEMSET
time ./memset_test

echo ZERO
time ./while_test
