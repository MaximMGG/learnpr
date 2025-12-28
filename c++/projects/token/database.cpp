#include "database.hpp"
#include <iostream>


#define DB_CONN_FMT "dbname=%s user=%s password=%s"
#define DB_CHECK_TOKEN_EXISTS "SELECT COUNT(*) FROM pg_tables WHERE schemaname = 'public' AND tablename = 'token'"
#define DB_CHECK_TOKEN_RELATION_EXISTS "SELECT COUNT(*) FROM pg_tables WHERE schemaname = 'public' AND tablename = 'token_relation'"
#define DB_CREATE_TABLE_TOKEN "CREATE TABLE token (" \
          "id INT,"                                  \
          "priceChange NUMERIC,"                     \
          "priceChangePercent NUMERIC,"              \
          "weightedAvgPrice NUMERIC,"                \
          "openPrice NUMERIC,"                       \
          "highPrice NUMERIC,"                       \
          "lowPrice NUMERIC,"                        \
          "lastPrice NUMERIC,"                       \
          "volume NUMERIC,"                          \
          "quoteVolume NUMERIC,"                     \
          "openTime INT,"                            \
          "closeTime INT,"                           \
          "firstId INT,"                             \
          "lastId INT,"                              \
          "count INT)"                             

#define DB_CREATE_TABLE_TOKEN_RELATION "CREATE TABLE token_relation ("  \
          "id INT,"                                                     \
          "symbol VARCHAR(32)"                                          \

#define DB_INSERT_TOKEN "INSERT INTO token (id, priceChange, priceChangePercent, weightedAvgPrice, "    \
                        "openPrice, highPrice, lowPrice, lastPrice, volume, quoteVolume, openTime, closeTime, "\
                        "firstId, lastId, count) VALUES(%ld, %lf, %lf, %lf, %lf, %lf, %lf, %lf, %lf, %lf, "    \
                        "%ld, %ld, %ld, %ld, %ld)"
#define DB_INSERT_TOKEN_RELATION "INSERT INTO token_relation (symbol) VALUES('%s')"




#define DB_SELECT_TOKEN_RELATION "SELECT * FROM token_relation"
#define DB_SELECT_TOKEN_RELATION_WHERE "SELECT * FROM token_relation WHERE symbol='%s'"
#define DB_SELECT_TOKEN_RELATION_ID_WHERE "SELECT id FROM token_relation WHERE symbol='%s'"

#define DB_DELETE_TOKEN_RELATION "DELETE FROM token_relation WHERE symbol='%s'"



Database::Database(const char *dbname, const char *user, const char *password) {
  char buf[256] = {0};
  sprintf(buf, DB_CONN_FMT, dbname, user, password);
  this->conn = PQconnectdb(buf);
  if (PQstatus(this->conn) != CONNECTION_OK) {
    std::cerr << "PQconnect error\n";
    return;
  }
}

Database::~Database() {
  PQfinish(this->conn);
}

std::string prepareInsertStr(Token *t) {
  i8 buf[512]{0};
  sprintf(buf, DB_INSERT_TOKEN, 
                           t->id,
                           t->ticker.priceChange,
                           t->ticker.priceChangePercent,
                           t->ticker.weightedAvgPrice,
                           t->ticker.openPrice,
                           t->ticker.highPrice,
                           t->ticker.lowPrice,
                           t->ticker.lastPrice,
                           t->ticker.volume,
                           t->ticker.quoteVolume,
                           t->ticker.openTime,
                           t->ticker.closeTime,
                           t->ticker.firstId,
                           t->ticker.lastId,
                           t->ticker.count);
  std::string res(buf);
  return res;
}

bool Database::insertToken(Token *t) {
  std::string query = prepareInsertStr(t);
  this->res = PQexec(this->conn, query.c_str());
  if (PQresultStatus(this->res) != PGRES_COMMAND_OK) {
    std::cerr << "PQexec: " << query << "Error\n";
    PQclear(this->res);
    return false;
  }
  PQclear(this->res);
  return true;
}

int Database::setTokenRelation(std::string &symbol) {
  if (getTokenRelation(symbol) != -1) {
    std::cout << "Token relation " << symbol << "exists\n";
    return -1;
  }
  i8 buf[512]{0};
  sprintf(buf, DB_INSERT_TOKEN_RELATION, symbol.c_str());
  this->res = PQexec(this->conn, buf);
  if (PQresultStatus(this->res) != PGRES_COMMAND_OK) {
    std::cerr << "PQexec: " << buf << "Error\n";
    PQclear(this->res);
    return -1;
  }
  PQclear(this->res);
  memset(buf, 0, 512);

  sprintf(buf, DB_SELECT_TOKEN_RELATION_ID_WHERE, symbol.c_str());
  this->res = PQexec(this->conn, buf);
  if (PQresultStatus(this->res) != PGRES_TUPLES_OK) {
    std::cerr << "PQexec: " << buf << "Error\n";
    PQclear(this->res);
    return -1;
  }
  
  i32 rows = PQntuples(this->res);
  if (rows == 0) {
    std::cerr << "Token relation: " << symbol << "doesn't exists\n";
    return -1;
  }

  i32 id = atol(PQgetvalue(this->res, 0, 0));
  PQclear(this->res);

  return id;
} 

std::vector<std::vector<std::string>> *Database::getTokenRelations() {
  i8 buf[512]{0};
  sprintf(buf, DB_SELECT_TOKEN_RELATION);
  this->res = PQexec(this->conn, buf);
  if (PQresultStatus(this->res) != PGRES_TUPLES_OK) {
    std::cerr << "PQexec: " << buf << "Error\n";
    return NULL;
  }
  i32 rows = PQntuples(this->res);
  if (rows == 0) {
    std::cout << "No tuples evelable\n";
    PQclear(this->res);
    return NULL;
  }
  auto res = new std::vector<std::vector<std::string>>();
  
  for(i32 i = 0; i < rows; i++) {
    res->push_back({});
  }

  i32 cols = PQnfields(this->res);

  for(i32 i = 0; i < rows; i++) {
    for(i32 j = 0; j < cols; j++) {
      (*res)[i].push_back(PQgetvalue(this->res, i, j));
    }
  }
  PQclear(this->res);

  return res;
} 

int Database::getTokenRelation(std::string &symbol) {
  i8 buf[512]{0};

  sprintf(buf, DB_SELECT_TOKEN_RELATION_ID_WHERE, symbol.c_str());
  this->res = PQexec(this->conn, buf);
  if (PQresultStatus(this->res) != PGRES_TUPLES_OK) {
    std::cerr << "PQexec: " << buf << "Error\n";
    PQclear(this->res);
    return -1;
  }
  
  i32 rows = PQntuples(this->res);
  if (rows == 0) {
    std::cerr << "Token relation: " << symbol << "doesn't exists\n";
    return -1;
  }

  i32 id = atol(PQgetvalue(this->res, 0, 0));
  PQclear(this->res);

  return id;
} 

void Database::deleteTokenRelation(std::string &symbol) {
  i8 buf[512]{0};
  sprintf(buf, DB_DELETE_TOKEN_RELATION, symbol.c_str());
  this->res = PQexec(this->conn, buf);
  if (PQresultStatus(this->res) != PGRES_COMMAND_OK) {
    std::cerr << "PQexec: " << buf << "Error\n";
  }
  PQclear(this->res);
} 

void Database::clearResult(std::vector<std::vector<std::string>> *res) {
  delete res;
} 

bool Database::query(std::string &query) {
  this->res = PQexec(this->conn, query.c_str());
  if (PQresultStatus(this->res) != PGRES_COMMAND_OK) {
    std::cerr << "Pexec: " << query << "Error\n";
    PQclear(this->res);
    return false;
  }
  PQclear(this->res);
  return true;
}  

std::vector<std::vector<std::string>> *Database::queryWithResult(std::string &query) {
  this->res = PQexec(this->conn, query.c_str());
  if (PQresultStatus(this->res) != PGRES_TUPLES_OK) {
    std::cerr << "PQexe: " << query << "Error\n";
    return nullptr;
  }
  return getResult();
}  

std::vector<std::vector<std::string>> *Database::getResult() {
  i32 rows = PQntuples(this->res);
  if (rows == 0) {
    std::cout << "No tuples evelable\n";
    PQclear(this->res);
    return NULL;
  }
  auto res = new std::vector<std::vector<std::string>>;
  i32 cols = PQnfields(this->res);

  for(i32 i = 0; i < rows; i++) {
    for(i32 j = 0; j < cols; j++) {
      res[i][j].push_back(PQgetvalue(this->res, i, j));
    }
  }
  PQclear(this->res);
  return res;
}  
