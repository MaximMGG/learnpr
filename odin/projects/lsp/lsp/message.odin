package lsp


request :: struct {
  RPC: string,
  ID: int,
  method: string,
}

response :: struct {
  RPC: string,
  ID: ^int,
}

notification :: struct {
  RPC: string,
  method: string,
}


