#include <string>

class Stock {
    private:
        Stock *stock = NULL;
        std::string name;
        long capasity;
        double average;
    public:
        Stock(std::string name = NULL, long capasity = 0, double average = 0.0);
        ~Stock();
        void set_name(const char *name);
        std::string get_name() const;
        void set_capasity(long capasity);
        long get_capasity() const;
        void set_average(double average);
        double get_average() const;
        void show_stock() const;
        bool compare(Stock& s);
};
