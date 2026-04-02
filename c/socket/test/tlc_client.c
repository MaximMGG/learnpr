#include <stdio.h>
#include <stdlib.h>
//#include <conio.h>
#include <openssl/ssl.h>
#include <openssl/err.h>
#include <sys/socket.h>
#include <netdb.h>
#include <arpa/inet.h>




int main(int argc, char **argv) {
	SSL_library_init();
	OpenSSL_add_all_algorithms();
	SSL_load_error_strings();

	SSL_CTX *ctx = SSL_CTX_new(TLS_client_method());
	if (!ctx) {
		fprintf(stderr, "SSL_CTX_new() error\n");
		return 1;
	}

	if (argc < 3) {
		fprintf(stderr, "usage: tls_client hostname port\n");
		return 1;
	}

	printf("Configuring remote address...\n");

	struct addrinfo hints;
	memset(&hints, 0, sizeof(hints));
	hints.ai_socktype = SOCK_STREAM;
	struct addrinfo *peer_address;
	if (getaddrinfo(argv[1], argv[2], &hints, &peer_address)) {
		fprintf(stderr, "getaddrinfo() failed.\n");
		return 1;
	}

	printf("Remote addres is:");

	char address_buffer[100];
	char service_buffer[100];
	getnameinfo(peer_address->ai_addr, peer_address->ai_addrlen, address_buffer, sizeof(address_buffer), service_buffer, sizeof(service_buffer), NI_NUMERICHOST);


	return 0;
}
