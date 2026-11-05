

extern fn  {
  fn SSL_new() -> u64;
  fn SSL_free(ssl: u64);
}


fn main() {
  let ssl = SSL_new();

  SSL_free(ssl);
}
