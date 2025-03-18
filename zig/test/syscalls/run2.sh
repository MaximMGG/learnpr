


./print_c $1 > print_c.txt
./args_print $1 > args_print.txt
./args_print $1 > args_print2.txt


echo "Print C"
cat print_c.txt | tail -n 2
echo "Print C in Zig"
cat args_print.txt | tail -n 2
echo "Print Zig"
cat args_print2.txt | tail -n 2

