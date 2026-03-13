#include "net.h"


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




  return net;
}

void netShutdown(Net *net);
void netRecvRequest(Net *net);
void netSendResponse(Net *net);
