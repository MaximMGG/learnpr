#ifndef NET_H
#define NET_H
#include <cstdext/core.h>
#include <netdb.h>
#include <sys/socket.h>
#include <sys/types.h>
#include <arpa/inet.h>
#include <netinet/ip.h>

typedef struct {
  i32 socket;

} Net;

Net *netInit();
void netShutdown(Net *net);
void netGetRequest(Net *net);
void netSendResponse(Net *net);

#endif
