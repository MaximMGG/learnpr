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
                    i--;
                } else if ( m_expression[i] == '+' || 
                            m_expression[i] == '-' ||
                            m_expression[i] == '*' ||
                            m_expression[i] == '/') {
                    Token tmp (TOKEN_OPERATION, 0, m_expression[i]);
                    if (in_bracket > 0) tmp.in_bracket();
                    tokens.push_back(tmp);
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
            while(expr_has_bracket()) {
                compute_expr_in_bracket();
            }
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


        bool expr_has_bracket() {
            for(int i = 0; i < tokens.size(); i++) {
                if (tokens[i].operation() == '(') return true;
            }
            return false;
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

            int i = b_start + 1;
            int j = i + 1;

            bool hight_prior = false;
            do {
                hight_prior = false;
                for(int k = j; k < b_end; k += 2) {
                    if (tokens[k].operation() == '*' || tokens[k].operation() == '/') {
                        hight_prior = true;
                        j = k;
                    }
                }

                if (hight_prior) {
                    if (tokens[j].operation() == '*') {
                        tokens[j - 1] = tokens[j - 1] * tokens[j + 1];
                    } else {
                        tokens[j - 1] = tokens[j - 1] / tokens[j + 1];
                    }
                    tokens.erase(tokens.begin() + j);
                    tokens.erase(tokens.begin() + j);
                    b_end -= 2;
                    i = b_start + 1;
                    j = i + 1;
                    continue;
                } else {
                    break;
                }
            } while(hight_prior);
            //2 * ( 10 )

            if (b_end - b_start < 3 ) {
                tokens.erase(tokens.begin() + b_end);
                tokens.erase(tokens.begin() + b_start);
                return;
            } 

            while(b_end - b_start > 2) {
                i = b_start + 1;
                j = i + 1;

                if (tokens[j].operation() == '+') {
                    tokens[i] = tokens[i] + tokens[j + 1];
                } else {
                    tokens[i] = tokens[i] - tokens[j + 1];
                }
                tokens.erase(tokens.begin() + j);
                tokens.erase(tokens.begin() + j);
                b_end -= 2;
            }
            tokens.erase(tokens.begin() + b_end);
            tokens.erase(tokens.begin() + b_start);
        }



        Token create_numer(const char *expr, int& i) {

            char buf[32]{0};
            int buf_i = 0;


            while(expr[i] >= '0' && expr[i] <= '9') {
                buf[buf_i++] = expr[i++];
            }

            Token a{TOKEN_NUMBER, std::atof(buf), 0};

            return a;
        }


        char m_expression[512]{0};
        unsigned int m_expr_len = 0;

};


#endif //CALC_H
