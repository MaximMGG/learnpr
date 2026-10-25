import std::io, std::os;



fn void main() {

  io::File *f = io::open("./total.txt", "r");
  f.close();
}



