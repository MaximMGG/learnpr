module test;
import std::io;


fn int? get_null_int(int a) {
  if (a > 0) {
    return 3;
  } else {
  }
  return 0;
}

fn void bin_data() {
  char[*] my_data = $embed("basic_types.c3");

  io::printn((String)(&my_data));

  io::printn("OPTIONAL");

  int res = get_null_int(3) ?? 1;

}

