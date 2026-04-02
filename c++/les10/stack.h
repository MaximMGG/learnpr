#ifndef _STACK_H_
#define _STACK_H_

typedef unsigned long Item;
const int MAX = 10;

class Stack {
    private:
        static const int Max = 10;
        Item items[Max];
        int top;
    public:
        Stack();
        bool isempty() const;
        bool isfull() const;

        bool push(const Item& item);
        bool pop(Item& item);
};




#endif //_STACK_H_
