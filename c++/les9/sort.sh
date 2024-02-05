#! /bin/sh


g++ sort.cpp -g -DBABLE
echo "Babble sort"
time ./a.out

g++ sort.cpp -g -DCHOSE
echo "Chosing sort"
time ./a.out

g++ sort.cpp -g -DFAST
time ./a.out
