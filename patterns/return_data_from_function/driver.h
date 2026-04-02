int ethernetDriverGetTotalReceicedPackets();
int ethernetDriverGetTotalSentPackets();


struct EthernetDriverInfo {
    char name[64];
    char description[1024];
};

struct EthernetDriverStat {
    int received_packets;
    int total_sent_packets;
    int successfully_sent_packets;
    int failed_sent_packets;
};

struct IpAddress {
    char address[16];
    char subnet[16];
};

void ethernetDriverGetIp(struct IpAddress *ip);
struct EthernetDriverStat ethernetDriverGetStatistics();
const struct EthernetDriverInfo* ethernetDriverGetInfo();
