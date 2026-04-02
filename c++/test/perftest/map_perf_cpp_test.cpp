#include <iostream>
#include <map>
#include <string>



bool increment_key(std::string &key) {
  int i = key.length() - 1;

  while(true) {
    if (key[i] < '9') {
      key[i] += 1;
      break;
    } else {
      key[i] = '0';
      i--;
      continue;
    }
  }
  if (key[3] == '1') {
    return false;
  }
  return true;
}

int main() {

  std::string key = "Key000000";
  int val = 1;

  std::map<std::string, int> m;
  std::cout << "Start inserting into map\n";
  while(increment_key(key)) {
    m[std::string(key)] = val;
    val++;
  }

  std::cout << "Finish inserting into map\n";
  
  for(auto i = m.begin(); i != m.end(); i++) {
//    std::cout << "Key -> " << i->first << ", Val -> " << i->second << '\n';
  }

  std::cout  << "Map size is: " << m.size() << '\n';

}
