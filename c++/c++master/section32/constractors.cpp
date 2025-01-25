#include <iostream>
#include <cstring>





struct Point {
    public:
        Point(double x = 10.1, double y = 100.1, const char *msg = NULL) : m_x(x), m_y(y){
            if (msg != NULL) {
                int len = std::strlen(msg);
                if (len > def_size) {
                    buf = new char[len]{0};
                } else {
                    buf = new char[def_size]{0};
                }
                std::strcpy(buf, msg);
            }
        }

        ~Point() {
            delete [] buf;
        }

        void print() {
            std::cout << "x : " << m_x << " y : " << m_y << '\n' << 
                "msg : " << buf << '\n';
        }

    private:
        static constexpr int def_size{100};

        double m_x{1};
        double m_y{1};
        char *buf;
};


int main() {

    Point *p = new Point{1, 2, "HEllo from main func"};

    p->print();

    delete p;

    return 0;
}
