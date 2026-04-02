#include <stdio.h>
#include "driver.h"


void ethShow() {
    struct EthernetDriverStat eth_stat = ethernetDriverGetStatistics();

    printf("Received packets %i\n", eth_stat.received_packets);
    printf("Sent packets %i\n", eth_stat.total_sent_packets);
    printf("Successfylly sent packets %i\n", eth_stat.successfully_sent_packets);
    printf("Failed sent packets %i\n", eth_stat.failed_sent_packets);

    const struct EthernetDriverInfo* eth_info = ethernetDriverGetInfo();
    printf("Driver name %s\n", eth_info->name);
    printf("Driver description %s\n", eth_info->description);

    struct IpAddress ip;
    ethernetDriverGetIp(&ip);
    printf("IP - address: %s\n", ip.address);
}

int main() {
    ethShow();

    return 0;
}
