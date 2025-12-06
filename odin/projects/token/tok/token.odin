package token

import "core:fmt"
import "core:net"
import "core:os"

HOST :: "api.binance.com"
PORT :: "443"
REQUEST :: "GET /api/v3/ticker?symbol=%s HTTP/1.1\r\nHost: api.binance.com\r\nConection: open\r\n\r\n"



