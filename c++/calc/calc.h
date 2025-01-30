#ifndef CALC_H
#define CALC_H

#include <vector>
#include <cmath>
#include <cstring>
#include <cstdlib>
#include <iostream>


enum TOCKEN_TYPE {
    TOKEN_NUMBER, TOKEN_OPERATION, TOKEN_BRACKET
};

class Token {
    public:
        Token(TOCKEN_TYPE type, double val, char operation) :
            m_type(type), m_val(val), m_operation(operation){};
        ~Token(){};
        void in_bracket() {
            m_bracket = true;
        }


        void out_bracket() {
            m_bracket = false;
        }

        Token& operator+(Token &a) {
            this->m_val += a.m_val;
            return *this;
        }

        Token& operator-(Token &a) {
            this->m_val -= a.m_val;
            return *this;
        }

        Token& operator*(Token &a) {
            this->m_val *= a.m_val;
            return *this;
        }
        Token& operator/(Token &a) {
            this->m_val /= a.m_val;
            return *this;
        }

        void pow(double index) {
            std::pow(this->m_val, index);
        }

        double val() {
            return m_val;
        }

        char operation() {
            return m_operation;
        }

        TOCKEN_TYPE type() {return m_type;}

    private:
        TOCKEN_TYPE m_type;
        double m_val{0.0};
        char m_operation{0};
        bool m_bracket;
};


class Compute {
    public:
        std::vector<Token> tokens;
        Compute(const char *expression) {
            std::strcpy(m_expression, expression);
            m_expr_len = std::strlen(expression);
        }

        int in_bracket = 0;
        void pars_expression() {
            for(int i = 0; i < m_expr_len; i++) {
                if (m_expression[i] >= '0' && m_expression[i] <= '9') {
                    Token tmp = create_numer(m_expression, i);
                    if (in_bracket > 0) tmp.in_bracket();
                    tokens.push_back(tmp);
                } else if ( m_expression[i] == '+' || 
                            m_expression[i] == '-' ||
                            m_expression[i] == '*' ||
                            m_expression[i] == '/') {
                    Token tmp (TOKEN_OPERATION, 0, m_expression[i]);
                    if (in_bracket > 0) tmp.in_bracket();
                    tokens.push_back(tmp);
                    i++;
                } else if (m_expression[i] == '(') {
                    Token tmp (TOKEN_BRACKET, 0, '(');
                    if (in_bracket > 0) 
                        tmp.in_bracket();
                    in_bracket++;
                    tokens.push_back(tmp);
                } else if (m_expression[i] == ')') {
                    in_bracket = in_bracket == 1 ? 0 : in_bracket - 1;
                    Token tmp (TOKEN_BRACKET, 0, ')');
                    if (in_bracket > 0) tmp.in_bracket();
                    tokens.push_back(tmp);
                }
            } 
        }

        void print_expression() {
            for(int i = 0; i < tokens.size(); i++) {
                if (tokens[i].type() == TOKEN_NUMBER)
                    std::cout << tokens[i].val() << ' ';
                else if (tokens[i].type() == TOKEN_OPERATION) {
                    std::cout << tokens[i].operation() << ' ';
                } else if (tokens[i].type() == TOKEN_BRACKET) {
                    std::cout << tokens[i].operation() << ' ';
                }
            }
        }

        ~Compute(){};

    private:

        Token create_numer(const char *expr, int& i) {

            char buf[32]{0};
            int buf_i = 0;


            while(expr[i] != ' ') {
                buf[buf_i++] = expr[i++];
            }
            i++;

            Token a{TOKEN_NUMBER, std::atof(buf), 0};

            return a;
        }


        char m_expression[512]{0};
        unsigned int m_expr_len = 0;

};


#endif //CALC_H
