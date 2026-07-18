#! /bin/bash


g++ strcpy1_test.cpp -o strcpy_std -g
g++ strcpy2_test.cpp -o strcpy_my -g


echo STRLEN_STD
time ./strcpy_std

echo STRLEN_MY
time ./strcpy_my
