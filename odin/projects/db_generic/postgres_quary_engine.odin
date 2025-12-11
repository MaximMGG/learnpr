package postgres_api

import "core:fmt"
import "core:strings"
import "core:log"

import "base:runtime"

Database :: struct {
    res: ^PGresult,
    conn: ^PGconn,

    db_name: string,
    user_name: string,
    user_password: string,

    prepared_inserts: map[string]string
}

CONNECT_STRING :: "dbname=%s user=%s password=%s"

engine_connect :: proc(db_name: string, user_name: string, user_password: string) -> ^Database {
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
engine_insert_prepare_quary :: proc(T: typeid) -> string {
    tin := type_info_of(T).variant.(runtime.Type_Info_Named)
    ti := tin.base.variant.(runtime.Type_Info_Struct)
    sb: ^strings.Builder = new(strings.Builder)
    strings.builder_init(sb)
    defer strings.builder_destroy(sb)
    strings.write_string(sb, "INSERT INTO ")
    strings.write_string(sb, tin.name)
    strings.write_string(sb, " (")

    for i in 0..<ti.field_count {
	strings.write_string(sb, ti.names[i])
	if i < ti.field_count - 1 {
	    strings.write_string(sb, ", ")	    
	} else {
	    strings.write_string(sb, ") ")
	}
    }
    strings.write_string(sb, " VALUES (")
    
    for i in 0..<ti.field_count {

	switch ti.types[i].id {
	case i8: fallthrough
	case u8: fallthrough
	case i16: fallthrough
	case u16: fallthrough
	case i32: fallthrough
	case u32: fallthrough	
	case i64: fallthrough
	case u64: fallthrough
	case int:
	    strings.write_string(sb, "%d")
	case f32:
	    strings.write_string(sb, "%f")
	case f64:
	    strings.write_string(sb, "%lf")
	case cstring: fallthrough
	case string:
	    strings.write_string(sb, "'%s'")
	}
	
	if i < ti.field_count - 1 {
	    strings.write_string(sb, ", ")	    
	} else {
	    strings.write_string(sb, ") ")
	}
    }
    res := strings.to_string(sb^)
    return strings.clone(res)
}

engine_get_insert_quary :: #force_inline proc(db: ^Database, T: typeid, mapping_name: string = "") -> string {
    quary: string
    if len(mapping_name) > 0 {
	if mapping_name in db.prepared_inserts {
	    quary = db.prepared_inserts[mapping_name]
	} else {
	    quary = engine_insert_prepare_quary(T)
	    db.prepared_inserts[mapping_name] = quary	    
	}
    } else {
	table_name := type_info_of(T).variant.(runtime.Type_Info_Named).name
	if table_name in db.prepared_inserts {
	    quary = db.prepared_inserts[table_name]
	} else {
	    quary = engine_insert_prepare_quary(T)
	    db.prepared_inserts[table_name] = quary
	}
    }

    return quary
}

engine_insert_struct :: proc(db: ^Database, t: $T, mapping_name: string = "") -> (ok: bool) {
    quary := engine_get_insert_quary(db, T, mapping_name)
    tin := type_info_of(T).variant.(runtime.Type_Info_Named)
    ti := tin.base.variant.(runtime.Type_Info_Struct)

    args := make([]any, ti.field_count)
    base := uintptr(&t)
    for i in 0..<ti.field_count {
	args[i] = (base + uintptr(ti.offsets[i]))^
    }
    buf := fmt.aprintf(quary, args)
    defer delete(buf)
    db.res = PQexec(db.conn, raw_data(buf))
    if db.res != PGRES_RESULT_OK {
	log.error("PQexec ", buf, " error")
	return false
    }
    PQclear(db.res)
    return true
}

destroy :: proc(db: ^Database) {
    if db.res != nil {
	PQclear(db.res)
    }
    PQfinish(db.conn)
    for k, v in db.prepared_inserts {
	delete(v)
    }
    free(db)
}
