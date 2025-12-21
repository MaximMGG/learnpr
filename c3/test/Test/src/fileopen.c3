module test;



import std::io::dir;
import std::io;
import std::io::file;

fn void file_test() {

  String s = "hello";

  io::File f = file::open("main.c3", "r")?;
  defer f.close()!!;

  f.seek(0, io::Seek.SET)!!;

  ichar [4096]buf;
  f.read(buf[..])!!;

  io::printn(buf);
}
