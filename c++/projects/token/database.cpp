#include "database.hpp"


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



Database::Database(char *dbname, char *user, char *password) {
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

int Database::setTokenRelation(std::string symsol) {
  return -1;
} 
std::vector<std::vector<std::string>> Database::getTokenRelations() {
} 
int Database::getTokenRelation(std::string symbol) {
} 
void Database::deleteTokenRelation(std::string symbol) {
} 
void Database::clearResult(std::vector<std::vector<std::string>> res) {
} 
bool Database::query(std::string query) {
}  
std::vector<std::vector<std::string>> Database::queryWithResult(std::string query) {
}  
std::vector<std::vector<std::string>> Database::getResult() {
}  
