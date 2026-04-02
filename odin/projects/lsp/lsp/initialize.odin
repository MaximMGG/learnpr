package lsp

initializeRequest :: struct {
  request: string,
  param: initializeRequestParams,
}

initializeRequestParams :: struct {
  client_info: ^clientInfo

}

clientInfo :: struct {

}
