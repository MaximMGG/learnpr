package storage

DB_CHECK_MODULE_TABLE_EXISTS : cstring : "SELECT COUNT(*) FROM pg_tables WHERE schemaname = 'public' AND tablename = 'modules'"
DB_CHECK_DICTIONARY_TABLE_EXISTS : cstring : "SELECT COUNT(*) FROM pg_tables WHERE schemaname = 'public' AND tablename = 'words'"
DB_CREATE_MODULE_TABLE : cstring : "CREATE TABLE module (id SIREAL PRIMARY KEY, module_name VARCHAR(64))"
DB_CREATE_WORDS_TABLE : cstring : "CREATE TABLE words (module_id INT FOREIGN KEY, word VARCHAR(128) NOT NULL, translation VARCHAR(128) NOT NULL);"
