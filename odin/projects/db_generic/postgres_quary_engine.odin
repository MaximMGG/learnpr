package postgres_api

import "core:fmt"
import "core:strings"
import "core:log"
import "core:mem"
import "core:strconv"

import "base:runtime"

Database :: struct {
    res: ^PGresult,
    conn: ^PGconn,

    db_name: string,
    user_name: string,
    user_password: string,

    prepared_inserts: map[string]string,
    prepared_selects: map[string]string,
}

CONNECT_STRING :: "dbname=%s user=%s password=%s"

engine_connect :: proc(db_name: string, user_name: string, user_password: string) -> ^Database {
    con_str := fmt.aprintf(CONNECT_STRING, db_name, user_name, user_password)
    defer delete(con_str)
    db := new(Database)
    db.conn = PQconnectdb(cstring(raw_data(con_str)))
    if PQstatus(db.conn) != CONNECTION_OK {
	fmt.eprintln("PQconnect with conn string: ", con_str, " error!")
	free(db)
    }
    db.db_name = db_name
    db.user_name = user_name
    db.user_password = user_password

    return db
}

@(private)
engine_insert_prepare_quary :: proc($T: typeid, mapping_name: string = "") -> string {
    tin := type_info_of(T).variant.(runtime.Type_Info_Named)
    ti := tin.base.variant.(runtime.Type_Info_Struct)
    sb: ^strings.Builder = new(strings.Builder)
    strings.builder_init(sb)
    defer strings.builder_destroy(sb)
    strings.write_string(sb, "INSERT INTO ")
    name := len(mapping_name) == 0 ? tin.name : mapping_name
    strings.write_string(sb, name)
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

engine_get_insert_quary :: #force_inline proc(db: ^Database, $T: typeid, mapping_name: string = "") -> string {
    quary: string
    if len(mapping_name) > 0 {
	if mapping_name in db.prepared_inserts {
	    quary = db.prepared_inserts[mapping_name]
	} else {
	    quary = engine_insert_prepare_quary(T, mapping_name)
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
    tmp := t
    base := uintptr(&tmp)
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
	    args[i] = ((^int)(base + uintptr(ti.offsets[i])))^
	case f32:
	    args[i] = ((^f32)(base + uintptr(ti.offsets[i])))^
	case f64:
	    args[i] = ((^f64)(base + uintptr(ti.offsets[i])))^
	case cstring: fallthrough
	case string:
	    args[i] = ((^string)(base + uintptr(ti.offsets[i])))^
	}
    }
    buf := fmt.aprintf(quary, ..args)
    defer delete(buf)
    db.res = PQexec(db.conn, cstring(raw_data(buf)))
    if PQresultStatus(db.res) != PGRES_COMMAND_OK {
	log.error("PQexec ", buf, " error")
	return false
    }
    PQclear(db.res)
    return true
}

@(private)
engine_get_select_prepared :: proc($T: typeid, mapping_name: string = "") -> string {
    tin := type_info_of(T).variant.(runtime.Type_Info_Named)
    name := len(mapping_name) == 0 ? tin.name : mapping_name
    return fmt.aprintf("SELECT * FROM %s", name)
}

@(private)
engine_get_select_quary :: proc(db: ^Database, $T: typeid, mapping_name: string = "") -> string {
    quary: string
    if len(mapping_name) != 0 {
	if mapping_name in db.prepared_selects {
	    quary = db.prepared_selects[mapping_name]
	} else {
	    quary = engine_get_select_prepared(T, mapping_name)
	    db.prepared_selects[mapping_name] = quary
	}
    } else {
	tin := type_info_of(T).variant.(runtime.Type_Info_Named)
	if tin.name in db.prepared_selects {
	    quary = db.prepared_selects[tin.name]
	} else {
	    quary = engine_get_select_prepared(T)
	    db.prepared_selects[tin.name] = quary
	}
    }
    return quary
}

engine_select_struct :: proc(db: ^Database, $T: typeid, mapping_name: string = "") -> T {
    quary := engine_get_select_quary(db, T, mapping_name)

    db.res = PQexec(db.conn, quary)
    if PQresultStatus(db.res) != PGRES_TUPLES_OK {
	log.error("PQexec ", quary, " error")
	return T{}
    }
    rows := PQntuples(db.res)
    tin := type_info_of(T).variant.(runtime.Type_Info_Named)
    ti := tin.base.variant.(runtime.Type_Info_Struct)
    t: T
    base := uintptr(&t)
    for i in 0..<ti.field_count {
	switch ti.types[i].id {
   	case i8:
	    res := PQgetvalue(db.res, 0, i)
	    res_int := strconv.parse_int(res, 10)
	    res_i8 := i8(res_int)
	    mem.copy(base + uintptr(ti.offsets[i]), &res_i8, size_of(i8))
	case u8:
	    res := PQgetvalue(db.res, 0, i)
	    res_int := strconv.parse_int(res, 10)
	    res_u8 := u8(res_int)
	    mem.copy(base + uintptr(ti.offsets[i]), &res_u8, size_of(u8))
	case i16:
	    res := PQgetvalue(db.res, 0, i)
	    res_int := strconv.parse_int(res, 10)
	    res_i16 := i16(res_int)
	    mem.copy(base + uintptr(ti.offsets[i]), &res_i16, size_of(i16))
	case u16: 
	    res := PQgetvalue(db.res, 0, i)
	    res_int := strconv.parse_int(res, 10)
	    res_u16 := u16(res_int)
	    mem.copy(base + uintptr(ti.offsets[i]), &res_u16, size_of(u16))
	case i32:
	    res := PQgetvalue(db.res, 0, i)
	    res_int := strconv.parse_int(res, 10)
	    res_i32 := i32(res_int)
	    mem.copy(base + uintptr(ti.offsets[i]), &res_i32, size_of(i32))
	case u32:
	    res := PQgetvalue(db.res, 0, i)
	    res_int := strconv.parse_int(res, 10)
	    res_u32 := u32(res_int)
	    mem.copy(base + uintptr(ti.offsets[i]), &res_u32, size_of(u32))
	case i64:
	    res := PQgetvalue(db.res, 0, i)
	    res_int := strconv.parse_int(res, 10)
	    res_i64 := i64(res_int)
	    mem.copy(base + uintptr(ti.offsets[i]), &res_i64, size_of(i64))
	case u64:
	    res := PQgetvalue(db.res, 0, i)
	    res_int := strconv.parse_int(res, 10)
	    res_u64 := u64(res_int)
	    mem.copy(base + uintptr(ti.offsets[i]), &res_u64, size_of(u64))
	case int:
	    res := PQgetvalue(db.res, 0, i)
	    res_int := strconv.parse_int(res, 10)
	    mem.copy(base + uintptr(ti.offsets[i]), &res_int, size_of(int))
	case f32:
	    res := PQgetvalue(db.res, 0, i)
	    res_float := strconv.parse_f32(res)
	    mem.copy(base + uintptr(ti.offsets[i]), &res_float, size_of(f32))
	case f64:
	    res := PQgetvalue(db.res, 0, i)
	    res_double := strconv.parse_f64(res)
	    mem.copy(base + uintptr(ti.offsets[i]), &res_double, size_of(f64))
	case cstring:
	    res := PQgetvalue(db.res, 0, i)
	    mem.copy(base + uintptr(ti.offsets[i]), &res_double, size_of(cstring))
	case string:
	    res := PQgetvalue(db.res, 0, i)
	    res_string := string(res)
	    mem.copy(base + uintptr(ti.offsets[i]), &res_double, size_of(string))
	}
    }

    return t
}

engine_destroy :: proc(db: ^Database) {
    PQfinish(db.conn)
    for k, v in db.prepared_inserts {
	delete(v)
    }
    free(db)
}


