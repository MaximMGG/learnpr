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

        void pars_expression() {
            int in_bracket = 0;
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

        void compute_expr() {
            compute_expr_in_bracket();
            if (tokens.size() == 1) return;
            compute_expr_hight_preority();
            if (tokens.size() == 1) return;

            for(int i = 0, j = 1; ;) {
                if (tokens.size() == 1) break;

                if (tokens[j].operation() == '+') {
                    tokens[i] = tokens[i] + tokens[j + 1];
                } else {
                    tokens[i] = tokens[i] - tokens[j + 1];
                }
                tokens.erase(tokens.begin() + j);
                tokens.erase(tokens.begin() + j);
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
            std::cout << '\n';
        }

        ~Compute(){};

    private:

//2 + 4 + ( 3 + 1 * 9 ) / 3
//

        void compute_expr_hight_preority() {
            
            for(int i = 0, j = 1; ;) {
                if (j + 2 == tokens.size()) {
                    if (tokens[j].operation() == '*') {
                        tokens[i] = tokens[i] * tokens[j + 1];
                        tokens.erase(tokens.begin() + 1);
                        tokens.erase(tokens.begin() + 1);
                    } else if ( tokens[j].operation() == '/') {
                        tokens[i] = tokens[i] / tokens[j + 1];
                        tokens.erase(tokens.begin() + 1);
                        tokens.erase(tokens.begin() + 1);
                    }
                    return;
                } else {
                    int mul_div = -1;
                    for(int k = 1; k < tokens.size(); k++) {
                        if (tokens[k].operation() == '*' || tokens[k].operation() == '/') {
                            mul_div = k;
                            break;
                        }
                    }
                    if (mul_div != -1) {
                        if (tokens[mul_div].operation() == '*') {
                            tokens[mul_div - 1] = tokens[mul_div - 1] * tokens[mul_div + 1];
                        } else {
                            tokens[mul_div - 1] = tokens[mul_div - 1] / tokens[mul_div + 1];
                        }
                        tokens.erase(tokens.begin() + mul_div);
                        tokens.erase(tokens.begin() + mul_div);
                    } else {
                        return;
                    }
                }
            }
        }

        void compute_expr_in_bracket() {
            int b_start = -1;
            int b_end = -1;
            for(int i = 0; i < tokens.size(); i++) {
                if (tokens[i].operation() == '(') {
                    b_start = i;
                }
                if (tokens[i].operation() == ')') {
                    b_end = i;
                    break;
                }
            }
            if (b_start == -1) return;

            for(int i = b_start + 1, j = b_start + 2; j < b_end; ) {

                if (j == b_end) {
                    tokens.erase(tokens.begin() + b_start);
                    tokens.erase(tokens.begin() + b_end);
                    break;
                }

                if (j + 2 < tokens.size() && j + 2 < b_end) {
                    if (tokens[j + 2].operation() == '*' || tokens[j + 2].operation() == '/') {
                        i = j + 1;
                        j += 2;
                        if (tokens[i + 1].operation() == '*') {
                            tokens[i] = tokens[i] * tokens[j];
                        } else {
                            tokens[i] = tokens[i] / tokens[j];
                        }
                        tokens.erase(tokens.begin() + i + 1);
                        tokens.erase(tokens.begin() + i + 1);
                        j = i + 1;
                        b_end -= 2;
                    } else {
                        switch(tokens[j].operation()) {
                            case '+': {
                                tokens[i] = tokens[i] + tokens[j + 1];
                            } break;
                            case '-': {
                                tokens[i] = tokens[i] - tokens[j + 1];
                            } break;
                            case '*': {
                                tokens[i] = tokens[i] * tokens[j + 1];
                            } break;
                            case '/': {
                                tokens[i] = tokens[i] / tokens[j + 1];
                            } break;
                        }
                        tokens.erase(tokens.begin() + i + 1);
                        tokens.erase(tokens.begin() + i + 1);
                        j = i + 1;
                        b_end -= 2;
                    }
                } else {
                    switch(tokens[j].operation()) {
                        case '+': {
                            tokens[i] = tokens[i] + tokens[j + 1];
                        } break;
                        case '-': {
                            tokens[i] = tokens[i] - tokens[j + 1];
                        } break;
                        case '*': {
                            tokens[i] = tokens[i] * tokens[j + 1];
                        } break;
                        case '/': {
                            tokens[i] = tokens[i] / tokens[j + 1];
                        } break;
                    }
                    tokens.erase(tokens.begin() + i + 1);
                    tokens.erase(tokens.begin() + i + 1);
                    j = i + 1;
                    b_end -= 2;
                }
            }
            compute_expr_in_bracket();
        }



        Token create_numer(const char *expr, int& i) {

            char buf[32]{0};
            int buf_i = 0;


            while(expr[i] != ' ' && expr[i] != '\n' && expr[i] != 0) {
                buf[buf_i++] = expr[i++];
            }

            Token a{TOKEN_NUMBER, std::atof(buf), 0};

            return a;
        }


        char m_expression[512]{0};
        unsigned int m_expr_len = 0;

};


#endif //CALC_H
