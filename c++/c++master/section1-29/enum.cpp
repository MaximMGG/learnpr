#include <iostream>
#include <string>

enum class Month : unsigned char{
    Jan, Feb, March, April, May, June = 234, July, August, September, October, November, December
};

enum DayOfWeek {
    Monday = 1, Tuesday, Wednesday, Thursday, Friday, Saturday, Sunday
};


using HugeInt = unsigned long long int;

typedef unsigned long long int HugeInt2;

std::string_view month_to_string(Month m) {
    switch(m) {
        using enum Month;
        case Jan  : return "January";
        case Feb : return "February";
        case March : return "March";
        case April : return "April";
        case May : return "May";
        case June : return "June";
        case July : return "July";
        case August : return "August";
        case September : return "September";
        case October : return "October";
        case November : return "November";
        case December : return "December";
    }
    return "";
}


void foo(DayOfWeek day) {
    switch(day) {
        case DayOfWeek::Monday : 
            std::cout << "Today is Monday";
            break;

        case DayOfWeek::Tuesday : 
            std::cout << "Today is Tuesday";
            break;

        case DayOfWeek::Wednesday : 
            std::cout << "Today is Wednesday";
            break;

        case  DayOfWeek::Thursday : 
            std::cout << "Today is Thursday";
            break;

        case DayOfWeek::Friday : 
            std::cout << "Today is Friday" ;
            break;

        case DayOfWeek::Saturday : 
            std::cout << "Today is Saturday";

        case DayOfWeek::Sunday : 
            std::cout << "Today is Sunday" ;
            break;

        default : 
            std::cout << "No day";
            break;
    }
}


int main() {
     
    DayOfWeek d {DayOfWeek::Tuesday};
    Month m {Month::September};

    foo(d);
    std::cout << "month is : " << month_to_string(m) << '\n';

    std::cout << DayOfWeek::Monday << '\n';
    std::cout << DayOfWeek::Tuesday << '\n';
    std::cout << DayOfWeek::Wednesday << '\n';
    std::cout << DayOfWeek::Thursday << '\n';
    std::cout << DayOfWeek::Friday << '\n';
    std::cout << DayOfWeek::Saturday << '\n';
    std::cout << DayOfWeek::Sunday << '\n';


    HugeInt a {123123123123};
    HugeInt2 b {12313212312313};
    std::cout << sizeof(a) << '\n';
    std::cout << sizeof(b) << '\n';

    return 0;
}
