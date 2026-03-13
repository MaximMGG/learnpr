#ifndef NET_H
#define NET_H
#include <cstdext/core.h>
#include <cstdext/container/list.h>
#include <cstdext/io/logger.h>
#include <netdb.h>
#include <sys/socket.h>
#include <sys/types.h>
#include <arpa/inet.h>
#include <netinet/ip.h>
#include <pthread.h>

typedef struct {
  i32 socket;
  List *modules;
  List *connections;

  Allocator *allocator;

} Net;

Net *netInit(Allocator *allocator, List *module);
void netShutdown(Net *net);
void netRecvRequest(Net *net);
void netSendResponse(Net *net);
void netWaitConnection(Net *net);
ptr netProcessConnection(ptr net);

#endif
