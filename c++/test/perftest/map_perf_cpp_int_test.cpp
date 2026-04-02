#include <iostream>
#include <map>


int main() {
  std::cout << "Begin\n";
  std::map<int, unsigned long> m;

  int key = 1;
  unsigned long val = 3;
  int count = 1000000;

  while(count != 0) {
    m[key] = val;
    key++;
    val += 123;

    count--;
  }

  unsigned long total_sum = 0;
  for(auto i = m.begin(); i != m.end(); i++) {
    total_sum += i->second;
  }

  std::cout << "Total sum: " << total_sum << '\n';

  return 0;
}
