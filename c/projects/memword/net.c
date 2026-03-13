#include "net.h"

typedef struct {
  Net *net;
  i32 conn;
} Net_Conn;

Net *netInit(Allocator *allocator, List *module) {
  Net *net = MAKE(allocator, Net);
  
  struct addrinfo hints = {0};
  hints.ai_family = AF_INET;
  hints.ai_socktype = SOCK_STREAM;
  hints.ai_flags = AI_PASSIVE;
  struct addrinfo *res;

  if (getaddrinfo("127.0.0.1", "8080", &hints, &res) == 0) {
    log(ERROR, "getaddrinfo error");
    DEALLOC(allocator, net);
    return null;
  }
  net->socket = socket(res->ai_family, res->ai_socktype, res->ai_protocol);
  if (net->socket <= 0) {
    log(ERROR, "socket error");
    DEALLOC(allocator, net);
    return null;
  }

  if (bind(net->socket, res->ai_addr, res->ai_addrlen)) {
    log(ERROR, "bind error");
    close(net->socket);
    DEALLOC(allocator, net);
    return null;
  }

  if (listen(net->socket, 10)) {
    log(ERROR, "listen error");
    close(net->socket);
    DEALLOC(allocator, net);
    return null;
  }
  log(INFO, "init net module");
  net->allocator = allocator;
  net->connections = listCreate(allocator, PTR);
  return net;
}

void netShutdown(Net *net) {
  close(net->socket);
  for(u32 i = 0; i < net->connections->len; i++) {
    DEALLOC(net->allocator, listGet(net->connections, i));
  }
  listDestroy(net->connections);
  DEALLOC(net->allocator, net);
  log(INFO, "shutdown net module");
}

ptr netProcessConnection(ptr net) {

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
  Net_Conn *nc = MAKE(net->allocator, Net_Conn);

  pthread_t worker;
  pthread_create(&worker, null, netProcessConnection, nc);

}

void netRecvRequest(Net *net) {
    
}

void netSendResponse(Net *net);
