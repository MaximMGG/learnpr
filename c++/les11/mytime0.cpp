#include "mytime0.h"
#include <iostream>

// Time::Time() {
//     hours = minutes = 0;
// }

Time::Time(int h, int m) {
    hours = h;
    minutes = m;
}

void Time::AddMin(int m) {
    minutes += m;
    hours += minutes / 60;
    minutes %= 60;
}

void Time::AddHr(int h) {
    hours += h;
}

void Time::Reset(int h, int m) {
    hours = h;
    minutes = m;
}

Time Time::operator+(const Time& t) const {
    Time s(0, 0);
    s.minutes = minutes + t.minutes;
    s.hours = hours + t.hours + s.minutes / 60;
    s.minutes %= 60;
    return s;
}
Time Time::operator-(const Time& t) const {
    Time sub{};
    sub.minutes = this->minutes - t.minutes;
    if (sub.minutes < 0) {
        sub.minutes += 60;
        sub.hours = -1;
    }
    sub.hours += this->hours - t.hours;
    return sub;
}

Time Time::operator*(double mult) const {
    Time result {0};
    long totalminutes = hours * mult * 60 + minutes * mult;
    result.minutes = totalminutes % 60;
    result.hours = totalminutes / 60;
    return result;
}

void Time::Show() const {
    std::cout << hours << " hours, " << minutes << " minutes.\n";
}

Time operator*(double m, const Time& t) {
    Time result {};
    long totalminutes = t.hours * m * 60 + t.minutes * m;
    result.minutes = totalminutes % 60;
    result.hours = totalminutes / 60;
    return result;
}

std::ostream& operator<<(std::ostream& os, const Time& t) {
    os << t.hours << " hours, " << t.minutes << " minutes";
    return os;
}

