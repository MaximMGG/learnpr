#include <stdio.h>
#include <string.h>
#include <cstdext/core.h>
#include <sys/socket.h>
#include <fcntl.h>
#include <sys/types.h>
#include <netdb.h>
#include <arpa/inet.h>
#include <unistd.h>
#include <netinet/in.h>

#define STD_RESPONSE "HTTP/1.1 200 OK\r\nContent-Type: text/html\r\nContent-Length: %d\r\nConnection: keep-alive\r\n\r\n%s"

i32 module = 0;

bool read_conn(i32 sock) {
  byte buf[512] = {0};
  i32 read_bytes = recv(sock, buf, 512, 0);
  if (read_bytes <= 0) {
    return false;
  }

  i32 find_module = strFind(buf, " /module.html ");
  if (find_module != -1) {
    module = 1;
  } else {
    module = 0;
  }

  printf("Read %d bytes\n%s\n", read_bytes, buf);

  return true;
}

void write_conn(i32 sock) {

  if (module) {
    i32 not_module = open("./not_module.html", O_RDONLY);

    byte module_buf[1024] = {0};
    i32 module_size = read(not_module, module_buf, 1024);

    byte response[4096] = {0};
    i32 response_size = sprintf(response, STD_RESPONSE, module_size, module_buf);

    i32 send_bytes = send(sock, response, response_size, 0);
    printf("Send %d bytes\n%s\n", response_size, response);

    module = 0;
  } else {

    i32 index = open("./index.html", O_RDONLY);
    if (index <= 0) {
      fprintf(stderr, "Can't open index.html\n");
      exit(1);
    }

    byte index_buf[2048] = {0};

    i32 index_size = read(index, index_buf, 2048);

    byte response[4096] = {0};

    i32 response_size = sprintf(response, STD_RESPONSE, index_size, index_buf);

    i32 send_bytes = send(sock, response, response_size, 0);
    printf("Send %d bytes\n%s\n", response_size, response);
  }

}

ptr process(ptr net) {
  i32 sock = *(i32 *) net;

  while(read_conn(sock)) {
    write_conn(sock);
  }
  return null;
}

int main() {

  struct addrinfo hints = {0};
  hints.ai_family = AF_INET;
  hints.ai_socktype = SOCK_STREAM;
  hints.ai_flags = AI_PASSIVE;
  struct addrinfo *res;

  if (getaddrinfo("127.0.0.1", "8080", &hints, &res)) {
    fprintf(stderr, "getaddrinfo failed\n");
    return 1;
  }

  i32 sock = socket(res->ai_family, res->ai_socktype, res->ai_protocol);
  if (sock <= 0) {
    fprintf(stderr, "socket failed\n");
    freeaddrinfo(res);
    return 1;
  }

  if (bind(sock, res->ai_addr, res->ai_addrlen)) {
    fprintf(stderr, "bind failed\n");
    close(sock);
    freeaddrinfo(res);
    return 1;
  }

  if(listen(sock, 10)) {
    fprintf(stderr, "listen failed\n");
    close(sock);
    freeaddrinfo(res);
    return 1;
  }

  freeaddrinfo(res);

  while(true) {

    struct sockaddr_storage incom = {0};
    socklen_t len = sizeof(incom);

    i32 new_conn = accept(sock, (struct sockaddr *)&incom, &len);
    if (new_conn <= 0) {
      fprintf(stderr, "Incoming connection broken\n");
      continue;
    }

    byte name[64] = {0};
    byte port[64] = {0};

    getnameinfo((struct sockaddr *)&incom, len, name, 64, port, 64, NI_NUMERICHOST | NI_NUMERICSERV);

    printf("New Connection %s - %s", name, port);

    pthread_t worker;
    pthread_create(&worker, null, process, &new_conn);
    pthread_detach(worker);
  }

  return 0;
}
