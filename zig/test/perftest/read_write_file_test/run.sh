#!/bin/sh

echo "Performans test write and read from file ZIG vs C"
echo "ZIG"
time ./main_zig $1 $2 2>/dev/null
echo "=================="

echo "C"
time ./main_c $1 $2 1>/dev/null
