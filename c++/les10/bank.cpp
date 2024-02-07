#include "bank.h"
#include <cinttypes>
#include <iostream>


Bank::Bank(std::string o_n, std::string num, long bal) {
    this->owner_name = o_n;
    this->number_ac = num;
    this->balance = bal;
}

void Bank::bank_info() const {
    std::cout << "Owner name: " << this->owner_name << ", number of balance is: " << this->number_ac
            << ", balance is: " << this->balance << ".\n";
}

void Bank::add_balance(long sum) {
    if (sum > 0) {
        this->balance += sum;
    }
}

long Bank::cash_withdrawl(long sum) {
    long res = 0;
    if (sum > 0) {
        if (this->balance - sum > 0) {
            res = sum;
        }
    }
    return res;
}



