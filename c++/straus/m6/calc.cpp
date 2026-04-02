#include <iostream>
#include <list>

#define LAST 11
#define FIRST 12


class Token {

    private:
        enum Type {
            OPERATION, NUMBER, BRACE
        };

        struct Element{
            Type type;
            int number;
            char symbol;
            bool in_brace;
        };

        std::list <Element> elements;
        std::list<Element>::iterator e_it;
    public:
        Element cur;
        int first_last_element;

        void prev_element() {
            cur = *(--e_it);
        }
        void next_element() {
            cur = *(++e_it);
        }

        void insert_element(Type type, int number, char symbol, bool in_brace) {
            Element n{type, type == NUMBER ? number : 0, symbol, in_brace};
            elements.push_back(n);
        }

        void delete_element(Element* el) {
            elements.remove(*el);
        }

        Token() {
            e_it = elements.begin();
        }
        ~Token();
};
