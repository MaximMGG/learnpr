package net_test

import "core:c/libc"

import "core:fmt"
import "core:os"
import "core:testing"
import "vendor:curl"
import "core:mem"
import "core:strings"
import "core:slice"


memory :: struct {
    response: []byte,
    size: libc.size_t,
}

cb :: proc(data: [^]byte, size: libc.size_t, nitems: libc.size_t, outstream: rawptr) -> libc.size_t {
    realsize: libc.size_t = nitems
    m: ^memory = cast(^memory)outstream
    new_ptr := libc.malloc(realsize + m.size + 1)
    m.response = slice.from_ptr(cast([^]u8)new_ptr, int(realsize + m.size + 1))
    mem.copy(&m.response[m.size], data, int(realsize))
    m.size += realsize
    m.response[m.size] = 0
    return realsize
}


main :: proc() {
    chunk: memory
    defer delete(chunk.response)
    Curl := curl.easy_init()
    res: curl.code
    if Curl != nil {
	curl.easy_setopt(Curl, .URL, "https://api.binance.com/api/v3/ticker?symbol=BTSUSDT")
	curl.easy_setopt(Curl, .WRITEFUNCTION, cb)
	curl.easy_setopt(Curl, .WRITEDATA, &chunk)
	curl.easy_setopt(Curl, .HEADER, 1)

	res = curl.easy_perform(Curl)

	curl.easy_cleanup(Curl)
    }
    s: string = strings.clone_from(chunk.response)
    defer libc.free(raw_data(chunk.response))
    fmt.println("Response: ", s)
}
