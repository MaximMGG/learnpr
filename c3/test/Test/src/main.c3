module test;
import std::io;
import std::os;

fn int main(String[] args) {
  io::printf("Hello %s", "in module test\n");

  basic_variables();
  printing_values();
  variables();
  expression();
  bin_data();
  statement_main();
  functions_main();
  io::printf("Hello world %s", "finally\n");
  
  return 0; 
}
