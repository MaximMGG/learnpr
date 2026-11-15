import std;

extern fn SSL_new() -> u64;
extern fn SSL_free(ssl: u64);

fn main() {
  let ssl = SSL_new();
  print("Create ssl");
  SSL_free(ssl);
}



