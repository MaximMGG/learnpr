module doc_examples;
import std::io;

fn int main() {
  call_bar(8);

  return 0;
}


fn void call_bar(int num_foo) {
  bar(num_foo);
}

<*
 @param num_foo
 @require num_foo > 4
*>
fn void bar(int num_foo) {
  io::printfn("Number of foo: %d", num_foo);
}
