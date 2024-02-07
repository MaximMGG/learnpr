#ifndef _MYTIME0_H_
#define _MYTIME0_H_
#include <iostream>


class Time {
    private:
        int hours;
        int minutes;
    public:
        // Time();
        Time(int h = 0, int m = 0);
        void AddMin(int m);
        void AddHr(int h);
        void Reset(int h = 0, int m = 0);
        Time operator+(const Time& t) const;
        Time operator-(const Time& t) const;
        Time operator*(double n) const;
        Time operator+=(const Time& t);
        friend Time operator*(double m, const Time& t);
        friend std::ostream& operator<<(std::ostream& os, const Time& t); void Show() const;
};
#endif //_MYTIME0_H_
