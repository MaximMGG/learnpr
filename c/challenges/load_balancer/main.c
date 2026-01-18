#include <cstdext/core.h>
#include <cstdext/io/logger.h>
#include <sys/socket.h>
#include <arpa/inet.h>
#include <netdb.h>
#include <pthread.h>
#include <stdio.h>

typedef struct {
  i32 load_sock;
  // i32 be_sock;
  i32 cl_sock;
} Load;


i32 create_server() {
  struct addrinfo hints = {0}, *res;
  hints.ai_family = AF_INET;
  hints.ai_socktype = SOCK_STREAM;
  hints.ai_flags = AI_PASSIVE;

  if (getaddrinfo("127.0.0.1", "8080", &hints, &res) != 0) {
    errorPanic("getaddrinfo error\n");
  }

  i32 sock = socket(res->ai_family, res->ai_socktype, res->ai_protocol);
  if (sock <= 0) {
    errorPanic("socket error\n");
  }
  if (bind(sock, res->ai_addr, res->ai_addrlen) != 0) {
    errorPanic("bind error\n");
  }

  freeaddrinfo(res);
  listen(sock, 10);

  return sock;
}

ptr redirect_worker(ptr p) {
  Load *l = (Load *)p;

  byte *buf = alloc(1024);
  memset(buf, 0, 1024);




  dealloc(l);
}

int main() {
  log(INFO, "Startup load_server");
  i32 sock = create_server();

  while(true) {
    struct sockaddr_storage in = {0};
    socklen_t sock_len = sizeof(in);
    i32 client_sock = accept(sock, (struct sockaddr *)&in, &sock_len);
    byte ip[128] = {0};
    getnameinfo((struct sockaddr *)&in, sock_len, ip, 128, 0, 0, NI_NUMERICHOST);
    Load *tmp = make(Load);
    tmp->load_sock = sock;
    tmp->cl_sock = client_sock;
    pthread_t t;
    pthread_create(&t, null, redirect_worker, tmp);
    pthread_detach(t);

    byte request_buf[1024] = {0};
    printf("Received request from %s\n", ip);
    i32 read_bytes = recv(client_sock, request_buf, 1024, 0);
    printf("%s\n", request_buf);

    close(client_sock);
  }

  log(INFO, "Shutdown load_server");
  return 0;
}
