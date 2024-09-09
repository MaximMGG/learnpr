#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>

#include <sys/socket.h>
#include <arpa/inet.h>
#include <netinet/in.h>
#include <sys/types.h>
#include <netdb.h>

#define PROXY       "127.0.0.1"
#define PROXYPORT   "9050"

typedef unsigned char int8;
typedef unsigned short int16;
typedef unsigned int int32;

/*
    void connect();
    void socket();
    void close();
    void htons();
    void inet_addr();
*/

typedef struct proxy_request{
    int8 vn;
    int8 cd;
    int16 dstport;
    int32 dstip;
    unsigned char useri[8];
}Req;

typedef struct proxy_response {
    int8 vn;
    int8 cd;
    int16 _;
    int32 __;
}Res;

/*
		        +----+----+----+----+----+----+----+----+----+----+....+----+
		        | VN | CD | DSTPORT |      DSTIP        | USERID       |NULL|
		        +----+----+----+----+----+----+----+----+----+----+....+----+
 # of bytes:	   1    1      2              4           variable       1
 */


/*
	            +----+----+----+----+----+----+----+----+
		        | VN | CD | DSTPORT |      DSTIP        |
		        +----+----+----+----+----+----+----+----+
 # of bytes:	   1    1      2              4 
 */
