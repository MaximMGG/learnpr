#include <iostream>
#include "database.hpp"


int main() {

  Database db("mydb", "maxim", "maxim");
  auto res = db.getTokenRelations();

  for(i32 i = 0; i < res->size(); i++) {
    std::cout << "ID: " << (*res)[i][0] << " Symbol " << (*res)[i][1] << '\n';
  }

  db.clearResult(res);
  return 0;
}
