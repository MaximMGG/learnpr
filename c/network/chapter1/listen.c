#include <sys/socket.h>
#include <netdb.h>
#include <ifaddrs.h>
#include <stdio.h>



//here we can now aur IP address

int main() {

    struct ifaddrs *addresses;

    if (getifaddrs(&addresses) == -1) {
        printf("gitifaddrs call failed\n");
        return -1;
    }

    struct ifaddrs *ad = addresses;
    while(ad) {
        int family = ad->ifa_addr->sa_family;
        if (family == AF_INET || family == AF_INET6) {
            printf("%s\t", ad->ifa_name);
            printf("%s\t", family == AF_INET ? "IPv4" : "IPv6");

            char ap[100];
            const int family_size = family == AF_INET ? sizeof(struct sockaddr_in) : sizeof(struct sockaddr_in6);
            getnameinfo(ad->ifa_addr, family_size, ap, sizeof(ap), 0, 0, NI_NUMERICHOST);
            printf("\t%s\n", ap);
        }
        ad = ad->ifa_next;
    }

    freeifaddrs(addresses);

    return 0;
}
