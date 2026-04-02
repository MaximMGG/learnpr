module functions;

import std::io;


fn void test(int times) {
  for (int i = 0; i < times; i++) {
    io::printfn("Hello %d", i);
  }
}

fn int test_with_default(int foo = 1) {
  return foo;
}

fn void test_named(int times, double data) {
  for(int i = 0; i < times; i++) {
    io::printf("Hello %d\n", i + data);
  }
}

fn void test_named_default(int times = 1, double data = 3.0, bool dummy = false) {
  for (int i = 0; i < times; i++) {
    io::printfn("Hello %f", i + data);
  }
}

fn void va_singletyped(int... args) {
  for(int i = 0; i < args.len; i++) {
    io::printfn("%d", args[i]);
  }
}

fn void va_variagnes_explicit(any... args) {
  for (int i = 0; i < args.len; i++) {
    io::printn(args[i]);
  }
}

fn void foo(int a, int b, int c) {
  io::printfn("%s, %s, %s", a, b, c);
}

fn double random_value() {
  return 0.4;
}

faultdef BAD_LUCK_ERROR, BAD_JOSS_ERROR;

fn double? test_error() {
  double val = random_value();
  if (val > 0.5) return BAD_LUCK_ERROR?;
  if (val >= 0.2) return BAD_JOSS_ERROR?;
  return val;
}


fn void print_input_with_explicit_checks() {
  String? line = io::treadline();
  if (try line) {
    int? val = line.to_int();
    if (try val) {
      io::printfn("You typed the number %d", val);
      return;
    }
  }
  io::printn("You didn't type an integer :/");
}

fn void main() {
  test(22);
  test_with_default();
  test_with_default(100);
  test_named(times: 1, data: 3.0);
  test_named(3, 4.0);
  test_named(15, data: 3.141592);

  test_named_default(times: 10, data: 3.5);

  test_named_default(3, dummy: false);

  //test_named_default(3, dummy: false) -> this is an error, overwriting an unnamed argument with a named argument

  va_singletyped(1, 2, 3, 4);
  //va_variagnes_explicit(3, 1, 33); can't cast to eny

  int x = 1;
  any v = &x;
  va_variagnes_explicit(&&1, &x, v);
  int[] arr = {1, 2};

  va_singletyped(...arr);

  foo(...arr[0..1], 7);
  io::printn("Test error");

  (void)io::printfn("%d", test_error());

  double x_d = (test_error() + test_error()) ?? 100;

  io::printfn("%d", x_d);

  print_input_with_explicit_checks();
  
}
