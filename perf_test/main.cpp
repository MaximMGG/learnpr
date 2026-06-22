#include <iostream>
#include <map>

bool increaseKey(std::string &key) {
  if (key[3] == '9') {
    return false;
  }

  int i = key.size() - 1;
  while(true) {
    if (key[i] == '9') {
      key[i] = '0';
      i--;
    } else {
      key[i]++;
      break;
    }
  }

  return true;
}


int main() {

  std::map<std::string, unsigned int>  m;

  std::string key("Key000000");
  unsigned int val = 0;

  while(increaseKey(key)) {
    m[std::string(key)] = val;
    val++;
  }

  std::cout << "Work is done, len is: " << m.size() << '\n';

  return 0;
}
