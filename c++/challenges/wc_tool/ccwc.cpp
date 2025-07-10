#include <cctype>
#include <iostream>
#include <fstream>
#include <cstring>
#include <cctype>

int get_count_of_chars(const char *file_name) {

}

int get_count_of_words(const char *file_name) {
    std::ifstream f;
    f.open(file_name);
    if (f.is_open()) {

        int words_count{};
        char buf[512] = {0};

        while(true) {
            if (f.eof()) {
                break;
            }
            f.getline(buf, 512, '\n');
            if (std::strlen(buf) == 1) {
                std::memset(buf, 0, 512);
                continue;
            }

            int word_len{};
            for(int i = 0; i < std::strlen(buf); i++) {
                if (buf[i] == ' ') {
                    if (word_len == 1) {
                        if (std::isalpha(buf[i - 1])) {
                            words_count++;
                        }
                    }
                    word_len = 0;
                }
                word_len++;
            }
            words_count++;
            word_len = 0;
            std::memset(buf, 0, 512);

        }

        return words_count;
    } else {
        return -1;
    }

}

int get_count_of_lines(const char *file_name) {

    std::ifstream f;
    f.open(file_name, std::ios_base::in);

    int line_count{};
    char buf[512];
    while(true) {
        f.getline(buf, 512, '\n');
        if (f.eof()) {
            break;
        }
        line_count++;
    }

    f.close();
    return line_count;
}

int get_count_of_chars(const char *file_name) {

    std::ifstream f;
    f.open(file_name, std::ios_base::in | std::ios_base::ate);
    std::streampos file_end;
    file_end = f.tellg();
    f.close();

    return int(file_end);
}


int main(int argc, char **argv) {

    if (argc > 1) {
        if (std::strcmp(argv[1], "-c") == 0) {
            std::cout << "File size: " << get_count_of_chars(argv[2]) << '\n';
        } else if (std::strcmp(argv[1], "-l") == 0) {
            std::cout << "count of lines: " << get_count_of_lines(argv[2]) << '\n';
        } else if (std::strcmp(argv[1], "-w") == 0) {
            std::cout << "Words: " << get_count_of_words(argv[2]) << '\n';
        }
    } else {

    }


    return 0;
}
