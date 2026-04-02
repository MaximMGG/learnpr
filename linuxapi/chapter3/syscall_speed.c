#include "../tlpi_hdr.h"

#ifndef NOSYSCALL
static int myfunc() {return 1;}
#endif

int main(int argc, char **argv) {
    int numCalls = (argc > 1) ? getInt(argv[1], GN_GT_0, "num-calls") : 10000000;

#ifdef NOSYSCALL
    printf("Calling nomral function\n");
#else
    printf("Calling getppid()\n");
#endif
    for(int j = 0; j < numCalls; j++) {
#ifdef NOSYSCALL
        myfunc();
#else
        pid_t mypid =  getppid();
        printf("%d\n", mypid);
#endif
    }


    exit(EXIT_SUCCESS);
}
