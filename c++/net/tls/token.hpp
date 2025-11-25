#include <iostream>
#include <string>
#include <vector>
#include <string.h>
#include <sys/socket.h>
#include <arpa/inet.h>
#include <netdb.h>
#include <unistd.h>
#include <openssl/ssl.h>
#include <openssl/err.h>

#define HOST "api.binance.com"
#define PORT "443"
#define REQUEST "GET /api/v3/ticker?symbol=$1 HTTP/1.1\r\nHost: api.binance.com\r\nConnection: open\r\n\r\n"




class Token {
private:
  SSL *ssl;
  SSL_CTX *ctx;
  int Socket;
public:
  std::string content;
  char *response = NULL;
/*
  {"symbol":"BTCUSDT","priceChange":"-1444.86000000","priceChangePercent":"-1.630","weightedAvgPrice":"87667.93943674","openPrice":"88652.88000000","highPrice":"89228.00000000","lowPrice":"86116.00000000","lastPrice":"87208.02000000","volume":"20153.59973000","quoteVolume":"1766824560.56199970","openTime":1764010920000,"closeTime":1764097365232,"firstId":5561869887,"lastId":5566673662,"count":4803776}
*/

  std::string symbol;
  double priceChange;
  double priceChangePercent;
  double weightedAvgPrice;
  double openPrice;
  double highPrice;
  double lowPrice;
  double lastPrice;
  double volume;
  double quoteVolume;
  long openTime;
  long closeTime;
  long firstId;
  long lastId;
  long count;

  std::vector<std::string> splitResponse() {
    std::vector<std::string> split;
    char *tmp = response + 1;
    int pos = 4;
    char buf[512]{0};
    for(int i = 0; i < strlen(tmp); i++) {
      if (tmp[i] == ',') {
        strncpy(buf, tmp + pos, i - pos);
        split.push_back(buf);
        memset(buf, 0, 512);
        pos = i + 1;
      }
      if (tmp[i] == '}') {
        strncpy(buf, tmp + pos, i - pos - 1);
      }
    }
    return split;
  }

  void parse() {

  }


  Token(std::string token_name) {
    content = REQUEST;
    std::string::size_type found = content.rfind("$1");
    content.replace(found, 2, token_name);

    SSL_library_init();
    SSL_load_error_strings();
    OpenSSL_add_ssl_algorithms();

    ctx = SSL_CTX_new(TLS_client_method());
    if (!ctx) {
      std::cerr << "SSL_CTX_new error\n";
      return;
    }

    struct addrinfo hints{0}, *res;
    hints.ai_family = AF_INET;
    hints.ai_socktype = SOCK_STREAM;

    if (getaddrinfo(HOST, PORT, &hints, &res) != 0) {
      std::cerr << "getaddrinfo error\n";
      return;
    }
    Socket = socket(res->ai_family, res->ai_socktype, res->ai_protocol);
    if (Socket < 0) {
      std::cerr << "socket error\n";
      return;
    }

    if (connect(Socket, res->ai_addr, res->ai_addrlen) != 0) {
      std::cerr << "connect error\n";
      close(Socket);
      return;
    }
    ssl = SSL_new(ctx);
    SSL_set_fd(ssl, Socket);

    if (SSL_connect(ssl) <= 0) {
      std::cerr << "SSL_connect error\n";
      close(Socket);
      return;
    }
  }
  ~Token() {
    if (response != NULL) {
      delete [] response;
    }
    SSL_shutdown(ssl);
    SSL_free(ssl);
    close(Socket);
    SSL_CTX_free(ctx);
    EVP_cleanup();
  }
  void request() {
    if (response != NULL) {
      delete [] response;
    }
    char buf[4096]{0};
    int read_bytes{0};
    int write_bytes{0};
    write_bytes = SSL_write(ssl, content.c_str(), content.size());
    if (write_bytes != content.size()) {
      std::cerr << "Write bytes: " << write_bytes << " not equalse content.size(): " << content.size() << '\n';
    }

    read_bytes = SSL_read(ssl, buf, 4096);
    char *s = strstr(buf, "\r\n\r\n");
    response = new char [strlen(s)];
    strcpy(response, s);
  }
};
