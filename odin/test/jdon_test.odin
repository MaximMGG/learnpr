package jdon_test

import "core:encoding/json"
import "core:fmt"
import io "core:io"
import os "core:os/os2"
import "core:strings"


main :: proc() {
	f, f_ok := os.open("config.json", {.Read, .Write})
	defer os.close(f)
	if f_ok != nil {
		fmt.eprintln("os.open error")
		return
	}
	buf: [1024]u8
	read_bytes, read_ok := os.read(f, buf[:])
	res, _ := json.parse(buf[:read_bytes])
	defer json.destroy_value(res)
	main := res.(json.Object)

	inputbuf: [128]u8

	dbname := main["dbname"].(json.String)
	if len(dbname) == 0 {
		read_bytes, read_ok = os.read(os.stdin, inputbuf[:])
		main["dbname"] = json.String(strings.clone(string(inputbuf[:read_bytes - 1])))
	}
	data, err := json.marshal(res)
	fmt.println(string(data))
	os.truncate(f, 0)
	os.seek(f, 0, io.Seek_From.Start)
	write_bytes, _ := os.write(f, data[:])
	defer delete(data)
}
