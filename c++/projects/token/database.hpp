#ifndef DATABASE_H
#define DATABASE_H
#include <libpq-fe.h>
#include "types.hpp"
#include <vector>
#include <string>
#include <iostream>
#include "token.hpp"

class Database {
public:
  Database(char *dbname, char *user, char *password);
  ~Database();
  
  bool insertToken(Token *t);
  int setTokenRelation(std::string symsol);
  std::vector<std::vector<std::string>> getTokenRelations();
  int getTokenRelation(std::string symbol);
  void deleteTokenRelation(std::string symbol);

  void clearResult(std::vector<std::vector<std::string>> res);

  bool query(std::string query);
  std::vector<std::vector<std::string>> queryWithResult(std::string query);
  std::vector<std::vector<std::string>> getResult();

private:
  PGconn *conn;
  PGresult *res;

};

#endif //DATABASE_H
