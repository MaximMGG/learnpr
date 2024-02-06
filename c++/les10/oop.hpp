#include <string>

class Stock {
    private:
        std::string name;
        long capasity;
        double average;
    public:
        Stock(std::string name = NULL, long capasity = 0, double average = 0.0);
        ~Stock();
        void set_name(const char *name);
        std::string get_name();
        void set_capasity(long capasity);
        long get_capasity();
        void set_average(double average);
        double get_average();
};
