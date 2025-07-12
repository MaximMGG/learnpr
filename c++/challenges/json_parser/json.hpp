#ifndef JSON_HPP
#define JSON_HPP
#include <iostream>
#include <fstream>
#include <cstdlib>
#include <cstring>

typedef enum {
    NUMBER, STRING, BOOLEAN, ARRAY, OBJECT, NULL_VALUE

} JSON_TYPE;

struct json_obj {
    public:
        json_obj(JSON_TYPE type) {
        }

        ~json_obj();
        JSON_TYPE type;
        union json_key {
            public:
                json_key();
                ~json_key();
                double number;
                bool boolean;
                std::string str;
        }key;
        json_obj *val;
};

class json {
    public:
        json_obj *json_cont;
        json() = default;
        json(std::string path_to_file) {
            std::ifstream f;
            f.open(path_to_file, std::ios_base::in);
            if (f.is_open()) {
                parse_json_obj(f);
            }
        }

        ~json() {
            delete [] json_buf;
        }


    private:
        std::string path_to_file;
        char *json_buf = nullptr;
        int json_buf_size = 0;
        int index = 0;
        bool valid = true;


        json_obj *parse_number(bool negative) {
            json_obj *tmp = new json_obj(NUMBER);
            char number_buf[48]{0};
            int buf_i{};

            if (negative) {
                number_buf[buf_i++] = '-';
            }

            while(json_buf[index] >= '0' && json_buf[index] <= '9' || json_buf[index] == '.') {
                number_buf[buf_i++] = json_buf[index++];
            }
            tmp->key.number = std::atof(number_buf);

            return tmp;

        }
        json_obj *parse_string() {
            json_obj *tmp = new json_obj(STRING);
            char string_buf[512];
            int buf_i{0};

            while(json_buf[index] != '"') {
                string_buf[buf_i++] = json_buf[index];
            }

            tmp->key.str = string_buf;

            return tmp;
        }

        json_obj *parse_boolean() {
            json_obj *tmp = new json_obj(BOOLEAN);
            if (json_buf[index] == 't') {
                if (std::strncmp(&json_buf[index], "true", 4) == 0) {
                    tmp->key.boolean = true;
                    index += 4;
                } else {
                    throw std::exception();
                }
            } else if (json_buf[index]  == 'f') {
                if (std::strncmp(&json_buf[index], "false", 5) == 0) {
                    tmp->key.boolean = false;
                    index += 5;
                } else {
                    throw std::exception();
                }
            }
            return tmp;
        }


        json_obj *parse_null() {
            json_obj *tmp = new json_obj(NULL_VALUE);

            if (std::strncmp(&json_buf[index], "null", 4) == 0) {
                index += 4;
            } else {
                throw std::exception();
            }

            return tmp;
        }

        json_obj *parse_array() {
            JSON_TYPE array_type;
            json_obj *tmp = new json_obj(ARRAY);


            while(valid) {
                if (json_buf[index] == ' ') continue;

                if (json_buf[index] == '{') {
                    array_type = OBJECT;
                    break;
                }
                if (json_buf[index] == '[') {
                    array_type = ARRAY;
                    break;
                }
                if (json_buf[index] == '"') {
                    array_type = STRING;
                    break;
                }
                if (json_buf[index] >= '0' && json_buf[index] <= '9' || json_buf[index] == '-') {
                    array_type = NUMBER;
                    break;
                }
                if (json_buf[index] == 't' || json_buf[index] == 'f') {
                    array_type = BOOLEAN;
                    break;
                } 
                if (json_buf[index] == 'n') {
                    array_type = NULL_VALUE;
                    break;
                } else {
                    throw std::exception();
                }
            }

            switch(array_type) {
                case NUMBER: {

                } break;
                case STRING: {

                } break;
                case BOOLEAN: {

                } break;
                case OBJECT: {

                } break;
                case NULL_VALUE: {

                } break;
                case ARRAY: {

                } break;
            }



            return tmp;
        }

        json_obj *parse_object() {
            json_obj *tmp = new json_obj(OBJECT);


            return tmp;
        }

        void parse_json_obj(std::istream& f) {
            std::streampos beg = f.tellg();
            f.seekg(0, std::ios_base::end);
            std::streampos end = f.tellg();
            f.seekg(0, std::ios_base::beg);
            json_buf_size = end - beg;
            if (json_buf_size < 2) {
                throw std::exception();
                return;
            }
            json_buf = new char [json_buf_size];

            int i{};
        }
};

#endif 
