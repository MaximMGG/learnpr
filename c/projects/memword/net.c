#include "net.h"
#include <cstdext/container/map.h>

typedef struct {
  Net *net;
  i32 conn;
} Net_Conn;


typedef enum {
  REQUEST_GET, REQUEST_POST,
} RequestType;

typedef struct {
  RequestType type;
  str path;
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

ptr netProcessConnection(ptr net) {
  Net_Conn *nc = (Net_Conn *) net;


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

  pthread_t worker;
  pthread_create(&worker, null, netProcessConnection, nc);
  pthread_detach(worker);
}

void netRecvRequest(Net *net) {
    
}

void netSendResponse(Net *net) {

}
