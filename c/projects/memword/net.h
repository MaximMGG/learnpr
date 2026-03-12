#ifndef NET_H
#define NET_H
#include <cstdext/core.h>
#include <cstdext/container/list.h>
#include <netdb.h>
#include <sys/socket.h>
#include <sys/types.h>
#include <arpa/inet.h>
#include <netinet/ip.h>

typedef struct {
  i32 socket;
  List *modules;

} Net;

Net *netInit(List *module);
void netShutdown(Net *net);
void netRecvRequest(Net *net);
void netSendResponse(Net *net);

#endif
