#ifndef _BANK_H_
#define _BANK_H_
#include <string>

class Bank {
    private:
        std::string owner_name;
        std::string number_ac;
        long balance;
    public:
        Bank(std::string o_n = "Non", std::string num = "00000", long bal = 0);
        void bank_info() const;
        void add_balance(long sum);
        long cash_withdrawl(long sum);
};


#endif //_BANK_H_
