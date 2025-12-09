package postgres_api

import "core:fmt"
import "core:strings"

Database :: struct {
    res: ^PGresult,
    conn: ^PGconn,

    db_name: string,
    user_name: string,
    user_password: string,

    prepared_inserts: map[string]string
}

CONNECT_STRING :: "dbname=%s user=%s password=%s"

connect :: proc(db_name: string, user_name: string, user_password: string) -> ^Database {
    con_str := fmt.aprintf(CONNECT_STRING, db_name, user_name, user_password)
    defer delete(con_str)
    db := new(Database)
    db.conn = PQconnectdb(cstring(raw_data(con_str)))
    if db.conn == nil {
	fmt.eprintln("PQconnect with conn string: ", con_str, " error!")
	free(db)
    }
    db.db_name = db_name
    db.user_name = user_name
    db.user_password = user_password

    return db
}

@(private)
insert_prepare_quary :: proc() -> string {
    a: [10]any

    return ""
}


insert_struct :: proc(db: ^Database, t: $T, mapping_name: string = "") -> (ok: bool) {
    quary: string
    if len(mapping_name) > 0 {
	if mapping_name in db.prepred_inserts {
	    quary = db.prepared_inserts[mapping_name]
	} else {
	    
	}
    }

    return true
}

destroy :: proc(db: ^Database) {
    if db.res != nil {
	PQclear(db.res)
    }
    PQfinish(db.conn)
    free(db)
}
