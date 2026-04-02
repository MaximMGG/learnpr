#ifndef JSON_HPP
#define JSON_HPP
#include <iostream>
#include <fstream>
#include <cstdlib>
#include <cstring>
#include <list>

typedef enum {
    NUMBER, STRING, BOOLEAN, ARRAY, OBJECT, NULL_VALUE
} JSON_TYPE;

class json_obj {
    public:
        json_obj(JSON_TYPE type) : type(type){}

        ~json_obj();

    private:
        JSON_TYPE type;

        std::string key;
        bool in_arr = false;

        union val{
            val();
            ~val();

            double num;
            std::string str;
            bool boo;
            std::list<json_obj> obj;
            std::list<json_obj> arr;
            void *n;
        } val;
};

class json {
    public:
        json(std::istream& json_stream) {
            json_stream.seekg(0, std::ios_base::beg);
            std::streampos beg = json_stream.tellg();
            json_stream.seekg(0, std::ios_base::end);
            std::streampos end = json_stream.tellg();

            this->json_buf_size = end - beg;
            this->json_buf = new char [json_buf_size + 1];

            json_stream.get(this->json_buf, this->json_buf_size);

        }

        json(std::string json_string) {
            this->json_buf_size = json_string.size();
            this->json_buf = new char [json_buf_size + 1];
            std::strcpy(this->json_buf, json_string.data());
        }

        ~json() {
            delete [] this->json_buf;
        }
    private:
        char *json_buf;
        int json_buf_size;
        int index{};
};

#endif 
