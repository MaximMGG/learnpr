module test;

import std::io;
import std::io::file;

fn void file_test() {

  String s = "hello";

  File f = file::open("main.c3", "r")!!;
  defer f.close()!!;

  f.seek(0, io::Seek.SET)!!;


  File *stderr = std::io::stderr();

  ichar [4096]buf;
  usz read_bytes = f.read(buf[..])!!;
  io::printn((String)buf[0..read_bytes]);

  stderr.write("Errorrororro\n")!!;
}
