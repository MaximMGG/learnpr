#include "net.h"
#include <cstdext/container/map.h>
#include "module.h"

typedef struct {
  Net *net;
  i32 conn;
  Module *cur_module;
  List *modules;
} Net_Conn;

typedef enum {
  REQUEST_GET, REQUEST_POST,
} RequestType;

typedef enum {
  INDEX, MODULE, CREATE_MODULE, DELETE_MODULE, COMBINE_MODULE
} PathType;

typedef struct {
  RequestType type;
  str path;
  PathType path_type;
  Map *headers;
} Request;

Net *netInit(List *module) {
  Net *net = make(Net);

  struct addrinfo hints = {0};
  hints.ai_family = AF_INET;
  hints.ai_socktype = SOCK_STREAM;
  hints.ai_flags = AI_PASSIVE;
  struct addrinfo *res;

  if (getaddrinfo("127.0.0.1", "8080", &hints, &res) == 0) {
    log(ERROR, "getaddrinfo error");
    dealloc(net);
    return null;
  }
  net->socket = socket(res->ai_family, res->ai_socktype, res->ai_protocol);
  if (net->socket <= 0) {
    log(ERROR, "socket error");
    dealloc(net);
    return null;
  }

  if (bind(net->socket, res->ai_addr, res->ai_addrlen)) {
    log(ERROR, "bind error");
    close(net->socket);
    dealloc(net);
    return null;
  }

  if (listen(net->socket, 10)) {
    log(ERROR, "listen error");
    close(net->socket);
    dealloc(net);
    return null;
  }
  log(INFO, "init net module");
  net->connections = listCreate(PTR);
  return net;
}

void netShutdown(Net *net) {
  close(net->socket);
  for(u32 i = 0; i < net->connections->len; i++) {
    dealloc(listGet(net->connections, i));
  }
  listDestroy(net->connections);
  dealloc(net);
  log(INFO, "shutdown net module");
}

bool netParseResponsePath(str path, Request *req) {
  if (strlen(path) == 1) {
    req->path = strCopy("/");
    req->path_type = INDEX;
  } else if (streql(path, "/module")) {
    req->path = null;
    req->path_type = MODULE;
  } else if (streql(path, "/create-module")) {
	req->path = "create-module.html";
	req->path_type = CREATE_MODULE;
  } else if (streql(path, "/delete-module")) {
	req->path = "delete-module.html";
	req->path_type = DELETE_MODULE;
  } else if (streql(path, "combine-module")) {
	req->path = "combine-module.html";
	req->path_type = COMBINE_MODULE;
  } else {
	return false;
  }
  
  return true;
}

Map *netParseHeaders(str buf) {
  str *headers_list = strSplit(buf, "\r\n");
  Map *header = mapCreate(STR, STR, null, null);
  for(u32 i = 0; i < ARR_LEN(headers_list); i++) {
	str *header_pair = strSplit(headers_list[i], ": ");
	mapPut(header, header_pair[0], header_pair[1]);
	arr_destroy(header_pair);
  }
  arr_destroy(headers_list);
  return header;
}

Request *netParseResponse(str buf) {
  Request *req = make(Request);
  i32 first_line = strFind(buf, "\r\n");
  if (first_line == -1) {
    dealloc(req);
    return null;
  }
  byte *first_line_buf = make_many(u8, first_line + 1);
  strncpy(first_line_buf, buf, first_line);
  first_line_buf[first_line] = 0;

  str *first_line_list = strSplit(first_line_buf, " ");
  if (streql(first_line_list[0], "GET")) {
    req->type = REQUEST_GET;
  } else if (streql(first_line_list[0], "POST")) {
    req->type = REQUEST_POST;
  } else {
	arr_destroy(first_line_list);
    dealloc(req);
    return null;
  }

  if (!netParseResponsePath(first_line_list[1], req)) {
	arr_destroy(first_line_list);
	dealloc(req);
	dealloc(first_line_buf);
	return null;
  }
  
  byte *headers_buf = null;
  i32 headers_end = strFind(buf, "\r\n\r\n");
  if (headers_end == -1) {
	arr_destroy(first_line_list);
	dealloc(req);
	dealloc(first_line_buf);
	return null;
  }
  arr_destroy(first_line_list);
  dealloc(first_line_buf);
  
  headers_buf = make_many(byte, headers_end - first_line - 2 + 1);
  memset(headers_buf, 0, headers_end - first_line - 2 + 1);
  strncpy(headers_buf, buf + first_line + 2, headers_end - 2 - first_line);
  req->headers = netParseHeaders(headers_buf);
  dealloc(headers_buf);
  
  return req;
}

Request *netRecvRequest(Net_Conn *conn) {
  i8 *buf = make_many(u8, 4096);
  memset(buf, 0, 4096);

  i32 read_bytes = recv(conn->conn, buf, 4096, 0);
  if (read_bytes == 0) {
    return make(Request);
  }
  if (read_bytes < 0) {
    return null;
  }
  
  return netParseResponse(buf);
}

void netSendResponse(Net_Conn *conn, Request *req) {
  if (req->type == REQUEST_GET) {
	switch(req->path_type) {
	case INDEX: {
	} break;
	case MODULE: {
	  
	} break;
	case CREATE_MODULE: {
	  
	} break;
	case DELETE_MODULE: {
	  
	} break;
	case COMBINE_MODULE: {
	  
	} break;
	}
	
  } else if (req->type == REQUEST_POST) {
	
  }
}

static void netDeallocRequest(Request *req) {

  if (req->headers != null) {
    Iterator *it = mapIterator(req->headers);
    while(mapItNext(it)) {
      dealloc(it->key);
      dealloc(it->val);
    }
    mapItDestroy(it);
    mapDestroy(req->headers);
    dealloc(req->path);
  }
  dealloc(req);
}

ptr netProcessConnection(ptr net) {
  Net_Conn *nc = (Net_Conn *) net;
  Request *req;

  while((req = netRecvRequest(nc)) != null) {
    netSendResponse(nc, req);
    netDeallocRequest(req);
  }
  return null;
}

void netWaitConnection(Net *net) {
  struct sockaddr_storage conn = {0};
  socklen_t conn_size = sizeof(conn);
  i32 new_conn = accept(net->socket, (struct sockaddr *)&conn, &conn_size);
  if (new_conn <= 0) {
    log(ERROR, "accept error");
    return;
  }
 
  byte name[128] = {0};
  byte port[128] = {0};

  getnameinfo((struct sockaddr *)&conn, conn_size, name, 128, port, 128, NI_NUMERICHOST | NI_NUMERICSERV);
  
  log(INFO, "New connection %s - %s", name, port);

  Net_Conn *nc = make(Net_Conn);
  nc->net = net;
  nc->conn = new_conn;
  nc->modules = net->modules;

  pthread_t worker;
  pthread_create(&worker, null, netProcessConnection, nc);
  pthread_detach(worker);
}


