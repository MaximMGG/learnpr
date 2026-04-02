#ifndef _GOLF_
#define _GOLF_

const int Len = 40;
struct golf {
    char fullname[Len];
    int handicap;
};

void setgolf(golf& g, const char *name, int hc);
int setgolf(golf& q);

void handicap(golf& g, int hc);
void showgolf(const golf& g);

#endif //_GOLF_
