#! /bin/sh


g++ main.cpp -O2 -o m_cpp
gcc main.c -O2 -lcext -o m_c
odin build main.odin -file -o:speed -out:m_odin


echo "CPP Map Iterations"
time ./m_cpp

echo "C Map Iterations"
time ./m_c

echo "ODIN Map Iterations"
time ./m_odin
