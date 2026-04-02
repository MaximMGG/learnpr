module methods;

import std::io;
import std::os;
import std;

struct Point {
  int x;
  int y;
}

fn void Point.add(Point *p, int x) {
  p.x += x;
}
fn void Point.sub(&self, int x) {
  self.x -= x;
}

fn void example() {
  Point p = {1, 2};
  p.add(10);

  Point.add(&p, 10);

  p.sub(11);
  io::printn(p);

}



enum State {
  STOPPED, RUNNING
}

fn bool State.may_open(State state) {
  switch(state) {
    case STOPPED: return true;
    case RUNNING: return false;
  }
}

fn void main() {
  example();
  State s = RUNNING;
  io::printn(s.may_open());
  
}
