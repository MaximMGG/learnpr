#include <cstdext/assert.h>
#include "../database.h"


TEST(database_init) {
  Database *db = databaseConnect("mydb", "maxim", "maxim");
  assert_not_null(db);

  databaseDisconnect(db);
}

TEST(database_select_test) {
  Database *db = databaseConnect("mydb", "maxim", "maxim");
  assert_not_null(db);

  QuaryRes res = databaseExecQuaryWithRes(db, "SELECT * FROM module;");
  str error = databaseGetError(db);
  for(i32 i = 0; i < res.rows; i++) {
    for(i32 j = 0; j < res.cols; j++) {
      printf("%s ", res.tuples[i][j]);
    }
    printf("\n");
  }
  printf("Status code: %s\n", error);
  databaseClearQuaryRes(&res);
  databaseDisconnect(db);
}


TEST_LIST(database_init, database_select_test)
