
int sum(int x, int y) {
    return x + y;
}

extern "C" int sum2(int x, int y);

int main() {

    for(int i = 0; i < 100000000; i++) {


#if defined(SUM)
    sum(4, 5 + i);
#elif defined (SUM2)
    sum2(4, 5 + i);
#endif

    }
    return 0;
}
