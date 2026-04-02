#include <stdio.h>
#include "driver.h"

//example with struct
void ethShow() {
    struct EthernetDriverStat eth_stat = ethernetDriverGetStatistics();

    printf("Received packets %i\n", eth_stat.received_packets);
    printf("Sent packets %i\n", eth_stat.total_sent_packets);
    printf("Successfylly sent packets %i\n", eth_stat.successfully_sent_packets);
    printf("Failed sent packets %i\n", eth_stat.failed_sent_packets);
}



/*
 *
void ethShow() {

    int total_sent_packets, successfully_sent_packets, failed_sent_packets;
    ethernetDriverGetStatistice(&total_sent_packets, &successfully_sent_packets, &failed_sent_packets);

    printf("Sent packets %d\n", total_sent_packets);
    printf("Successfully sent packets %d\n", successfully_sent_packets);
    printf("Failed sent packets %d\n", failed_sent_packets);

    int received_packets = ethernetDriverGetTotalReceicedPackets();
    printf("Total received packets %d\n", received_packets);

}
*/
