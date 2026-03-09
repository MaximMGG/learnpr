#include "database.h"
#include <string.h>
#include <stdio.h>
#include <stdarg.h>

#define DATABASE_CONNECT_QUARY "dbname=%s user=%s password=%s"

#define DATABASE_CHECK_COLUMS_TYPE_NAME "SELECT column_name, data_type, character_maximum_length, is_identity, column_default, FROM information_schema.columns WHERE table_schema = 'public' AND table_name = '%s';"
#define DATABASE_CHECK_TABLE_EXISTS "SELECT COUNT(*) FROM pg_tables WHERE schemaname = 'public' AND tablename = '%s';"

#define DB_POSTGRES_TYPE_LEN 9 
#define DB_POSTGRES_TYPE_NONE 983472938
str db_postgres_type[] = {
  "smallint",
  "integer",
  "bigint",
  "real",
  "double precision",
  "character varying",
  "boolean",
  "decimal",
  "numeric"
};

str database_error_str[] = {
  "DATABASE_OK",
  "DATABASE_CONNECT_ERROR",
  "DATABASE_INSERT_ERROR",
  "DATABASE_SELECT_ERROR",
  "DATABASE_INSERT_STRUCT_ERROR",
  "DATABASE_SELECT_STRUCT_ERROR",
  "DATABASE_EXEC_QUARY_WITH_RES_ERROR",
  "DATABASE_EXEC_QUARY_WITHOUT_RES_ERROR",
};

Database *databaseConnect(Allocator *allocator, str db_name, str user_name, str password) {
  Database *db = MAKE(allocator, Database);
  byte buf[1024] = {0};
  sprintf(buf, DATABASE_CONNECT_QUARY, db_name, user_name, password);
  db->conn = PQconnectdb(buf);
  if (PQstatus(db->conn) != CONNECTION_OK) {
    DEALLOC(allocator, db);
    fprintf(stderr, "DATABASE: not connect!\n");
    return null;
  }

  db->allocator = allocator;

  db->db_name = strCopy(allocator, db_name);
  db->user_name = strCopy(allocator, user_name);
  db->password = strCopy(allocator, password);

  db->prepared_insert = mapCreate(allocator, STR, STR, null, null);
  db->prepared_select = mapCreate(allocator, STR, STR, null, null);

  db->quary_result = DATABASE_OK;

  return db;
}

void databaseDisconnect(Database *db) {
  DEALLOC(db->allocator, db->db_name);
  DEALLOC(db->allocator, db->user_name);
  DEALLOC(db->allocator, db->password);


  Iterator *it = mapIterator(db->prepared_insert);
  while(mapItNext(it)) {
    DEALLOC(db->allocator, it->key);
    DEALLOC(db->allocator, it->val);
  }
  mapItDestroy(it);
  mapDestroy(db->prepared_insert);
  it = mapIterator(db->prepared_select);
  while(mapItNext(it)) {
    DEALLOC(db->allocator, it->key);
    DEALLOC(db->allocator, it->val);
  }
  mapItDestroy(it);
  mapDestroy(db->prepared_select);
  DEALLOC(db->allocator, db);
}

//INSERT INTO dictionary(word, translation) VALUES('%s', '%s')

void databaseInsert(Database *db, str quary, ...) {
  va_list li;
  va_start(li, quary);
  byte *quary_buf = ALLOC(db->allocator, 4096);
  memset(quary_buf, 0, 4096);
  vsprintf(quary_buf, quary, li);

  db->res = PQexec(db->conn, quary_buf);
  if (PQresultStatus(db->res) != PGRES_COMMAND_OK) {
    db->quary_result = DATABASE_INSERT_ERROR;
  } else {
    db->quary_result = DATABASE_OK;
  }

  PQclear(db->res);
  va_end(li);
  DEALLOC(db->allocator, quary_buf);
}

QuaryRes databaseSelect(Database *db, str quary) {
  QuaryRes qr;

  db->res = PQexec(db->conn, quary);
  if (PQresultStatus(db->res) != PGRES_TUPLES_OK) {
    db->quary_result = DATABASE_SELECT_ERROR;
    PQclear(db->res);
    return (QuaryRes){};
  } else {
    db->quary_result = DATABASE_OK;
  }

  qr.rows = PQntuples(db->res);
  qr.cols = PQnfields(db->res);
  qr.tuples = MAKE_MANY(db->allocator, str *, qr.rows);

  for(i32 i = 0; i < qr.rows; i++) {
    for(i32 j = 0; j < qr.cols; j++) {
      str res = PQgetvalue(db->res, i, j);
      qr.tuples[i][j] = strCopy(db->allocator, res);
    }
  }
  PQclear(db->res);

  return qr;
}

static u32 databaseGetDataType(str type) {
  for(u32 i = 0; i < DB_POSTGRES_TYPE_LEN; i++) {
    if (strcmp(db_postgres_type[i], type) == 0) {
      return i;
    }
  }
  return DB_POSTGRES_TYPE_NONE;
}


static str databaseInsertStructPrepareQuary(Database *db, str table) {
  byte quary_buf[1024] = {0};
  sprintf(quary_buf, DATABASE_CHECK_COLUMS_TYPE_NAME, table);
  QuaryRes qr = databaseExecQuaryWithRes(db, quary_buf);
  if (db->quary_result != DATABASE_OK) {
    db->quary_result = DATABASE_INSERT_STRUCT_ERROR;
    return null;
  }

  strbuf *insert_struct_buf = strbufCreate(db->allocator);
  strbuf *insert_struct_value = strbufCreate(db->allocator);

  strbufAppendFormat(insert_struct_buf, "INSERT INTO %s (", table);
  strbufAppend(insert_struct_value, "VALUES (");
//column_name, data_type, character_maximum_length, is_identity, column_default,
  i8 element = 1;
  for(i32 i = 0; i < qr.rows; i++) {
    if (strlen(qr.tuples[i][3]) > 0 || (strlen(qr.tuples[i][4]) > 0)) {
      continue;
    } else {
      if (i == qr.rows - 1) {
        strbufAppendFormat(insert_struct_buf, "%s) ", qr.tuples[i][0]);
        strbufAppendByte(insert_struct_value, '$');
        strbufAppendFormat(insert_struct_value, "%d);", element);
      } else {
        strbufAppendFormat(insert_struct_buf, "%s, ", qr.tuples[i][0]);
        strbufAppendByte(insert_struct_value, '$');
        strbufAppendFormat(insert_struct_value, "%d, ", element++);
      }
      
    }
  }
  str values = strbufToString(insert_struct_value);
  strbufAppend(insert_struct_buf, values);

  str result = strCopy(db->allocator, strbufToString(insert_struct_buf));

  strbufDestroy(insert_struct_value);
  strbufDestroy(insert_struct_buf);
  databaseClearQuaryRes(db->allocator, &qr);
  return result;
}


static i32 g_pos = -1;
static str g_struct_var = null;
static u32 g_len = 0;

static CORE_TYPES databaseInsertStructNextVal(str struct_variables) {
  if (g_struct_var == null) {
    g_pos = 0;
    g_struct_var = struct_variables;
    g_len = strlen(struct_variables);
  }

  while(g_struct_var[g_pos] != '%') {
    if (g_pos == g_len) {
      g_pos = -1;
      g_struct_var = null;
      g_len = 0;
      return CORE_NULL;
    }
  }
  g_pos++;
  if (g_struct_var[g_pos] == 'l') {
    g_pos++;
    if (g_struct_var[g_pos == 'd']) {
      g_pos++;
      return I64;
    }
    if (g_struct_var[g_pos] == 'f') {
      g_pos++;
      return F64;
    }
    if (g_struct_var[g_pos] == 'u') {
      g_pos++;
      return U64;
    }
    return CORE_NULL;
  }
  CORE_TYPES t = CORE_NULL;
  switch(g_struct_var[g_pos]) {
    case 'd': {
      t = I32;
    } break;
    case 'f': {
      t = F32;
    } break;
    case 'u': {
      t = U32;
    } break;
    case 's': {
      t = STR; 
    } break;
    case 'c': {
      t = I8;
    } break;
    default: {t = CORE_NULL;}
  }

  g_pos++;
  return t;
}

void databaseInsertStruct(Database *db, str table, str struct_variables, ptr val) {
  KV res = mapGet(db->prepared_insert, table);
  str quary;
  if (res.val == null) {
    quary = databaseInsertStructPrepareQuary(db, table);
    mapPut(db->prepared_insert, strCopy(db->allocator, table), quary);
  } else {
    quary = res.val;
  }
  str tmp_quary = strCopy(db->allocator, quary);
  u32 type;
  u32 element = 1;
  str element_fmt = "$%d";
  byte element_buf[32] = {0};
  byte *base = val;
  u32 offset = 0;
  byte val_buf[128] = {0};
  while((type = databaseInsertStructNextVal(struct_variables)) != CORE_NULL) {
    switch(type) {
      case I32: {
        i32 tmp_val = *(i32 *)(base + offset);
        offset += sizeof(i32);
        sprintf(val_buf, "%d", tmp_val);
        sprintf(element_buf, element_fmt, element++);
        str q = strReplace(db->allocator, tmp_quary, element_buf, val_buf);
        DEALLOC(db->allocator, tmp_quary);
        tmp_quary = q;
        memset(element_buf, 0, 32);
        memset(val_buf, 0, 128);
      } break;
      case U32: {
        u32 tmp_val = *(u32 *)(base + offset);
        offset += sizeof(u32);
        sprintf(val_buf, "%u", tmp_val);
        sprintf(element_buf, element_fmt, element++);
        str q = strReplace(db->allocator, tmp_quary, element_buf, val_buf);
        DEALLOC(db->allocator, tmp_quary);
        tmp_quary = q;
        memset(element_buf, 0, 32);
        memset(val_buf, 0, 128);
      } break;
      case I64: {
        i64 tmp_val = *(i64 *)(base + offset);
        offset += sizeof(i64);
        sprintf(val_buf, "%ld", tmp_val);
        sprintf(element_buf, element_fmt, element++);
        str q = strReplace(db->allocator, tmp_quary, element_buf, val_buf);
        DEALLOC(db->allocator, tmp_quary);
        tmp_quary = q;
        memset(element_buf, 0, 32);
        memset(val_buf, 0, 128);
      } break;
      case U64: {
        u64 tmp_val = *(u64 *)(base + offset);
        offset += sizeof(u64);
        sprintf(val_buf, "%lu", tmp_val);
        sprintf(element_buf, element_fmt, element++);
        str q = strReplace(db->allocator, tmp_quary, element_buf, val_buf);
        DEALLOC(db->allocator, tmp_quary);
        tmp_quary = q;
        memset(element_buf, 0, 32);
        memset(val_buf, 0, 128);
      } break;
      case F32: {
        f32 tmp_val = *(f32 *)(base + offset);
        offset += sizeof(f32);
        sprintf(val_buf, "%f", tmp_val);
        sprintf(element_buf, element_fmt, element++);
        str q = strReplace(db->allocator, tmp_quary, element_buf, val_buf);
        DEALLOC(db->allocator, tmp_quary);
        tmp_quary = q;
        memset(element_buf, 0, 32);
        memset(val_buf, 0, 128);
      } break;
      case F64: {
        f64 tmp_val = *(f64 *)(base + offset);
        offset += sizeof(f64);
        sprintf(val_buf, "%lf", tmp_val);
        sprintf(element_buf, element_fmt, element++);
        str q = strReplace(db->allocator, tmp_quary, element_buf, val_buf);
        DEALLOC(db->allocator, tmp_quary);
        tmp_quary = q;
        memset(element_buf, 0, 32);
        memset(val_buf, 0, 128);
      } break;
      case STR: {

      } break;
      case I8: {

      } break;
      default: {}
    }
  }

}


QuaryStructRes databaseSelectStruct(Database *db, str table, str struct_variables, str quary) {

  return (QuaryStructRes){};
}



QuaryRes databaseExecQuaryWithRes(Database *db, str quary) {
  db->res = PQexec(db->conn, quary);
  if (PQresultStatus(db->res) != PGRES_TUPLES_OK) {
    db->quary_result = DATABASE_EXEC_QUARY_WITH_RES_ERROR;
    PQclear(db->res);
    return (QuaryRes){};
  }
  db->quary_result = DATABASE_OK;

  QuaryRes res;
  res.rows = PQntuples(db->res);
  res.cols = PQnfields(db->res);

  res.tuples = MAKE_MANY(db->allocator, str *, res.rows);

  for(i32 i = 0; i < res.rows; i++) {
    for(i32 j = 0; j < res.cols; j++) {
      str val = PQgetvalue(db->res, i, j);
      res.tuples[i][j] = strCopy(db->allocator, val);
    }
  }

  PQclear(db->res);
  return res;
}

void databaseExecQuaryWithoutRes(Database *db, str quary) {
  db->res = PQexec(db->conn, quary);
  if (PQresultStatus(db->res) != PGRES_COMMAND_OK) {
    db->quary_result = DATABASE_EXEC_QUARY_WITHOUT_RES_ERROR;
    PQclear(db->res);
  }
  db->quary_result = DATABASE_OK;
  PQclear(db->res);
}

str databaseGetError(Database *db) {
  return database_error_str[db->quary_result];
}

void databaseClearQuaryRes(Allocator *allocator, QuaryRes *qr) {
  for(i32 i = 0 ; i < qr->rows; i++) {
    for(i32 j = 0; j < qr->cols; j++) {
      DEALLOC(allocator, qr->tuples[i][j]);
    }
  }
  DEALLOC(allocator, qr->tuples);
}
