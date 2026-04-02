#include <stdio.h>
#include <unistd.h>
#include <linux/reboot.h>
#include <sys/reboot.h>




int main() {

    printf("0x%x\n", LINUX_REBOOT_MAGIC2);
    printf("0x%x\n", LINUX_REBOOT_MAGIC2A);
    printf("0x%x\n", LINUX_REBOOT_MAGIC2B);
    printf("0x%x\n", LINUX_REBOOT_MAGIC2C);


    return 0;
}
