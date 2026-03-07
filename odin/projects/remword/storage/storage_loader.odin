package storage

DB_CHECK_MODULE_TABLE_EXISTS : cstring : "SELECT COUNT(*) FROM pg_tables WHERE schemaname = 'public' AND tablename = 'module'"
DB_CHECK_DICTIONARY_TABLE_EXISTS : cstring : "SELECT COUNT(*) FROM pg_tables WHERE schemaname = 'public' AND tablename = 'dictionary'"
DB_CREATE_MODULE_TABLE : cstring : "CREATE TABLE module (id SIREAL)"
