#include <cctype>
#include <iomanip>
#include <iostream>
#include <fstream>
#include <cstring>
#include <cctype>
#include <locale>
#include <codecvt>

int get_count_of_chars(const char *file_name) {
    std::wfstream f(file_name);

    std::wstring l;

    f.imbue(std::locale(f.getloc(), new std::codecvt_utf8_utf16<wchar_t>));
    if (f.is_open()) {
        int char_count{};
        while(!f.eof()) {
            std::getline(f, l);
            char_count += l.size();
            char_count++;
        }
        f.close();
        return char_count - 1;
    }

    return -1;
}

int get_count_of_words(std::ifstream& f) {
    std::string s;
    int words_count{};
    while(std::getline(f, s)) {
        int i{};
        while(i < s.size()) {
            if (std::isspace(s[i])) {
                i++;
                continue;
            }
            words_count++;
            while(i < s.size() && !std::isspace(s[i]))
                i++;
        }
    }
    return words_count++;
}

int get_count_of_lines(std::ifstream& f) {

    int line_count{};
    char buf[512];
    while(true) {
        f.getline(buf, 512, '\n');
        if (f.eof()) {
            break;
        }
        line_count++;
    }

    return line_count;
}

int get_count_of_bytes(std::ifstream& f) {

    std::streampos file_end;
    file_end = f.tellg();

    return int(file_end);
}


int main(int argc, char **argv) {

    if (argc == 1) {
        std::cerr << "Usage [ccwc] [-flag] (optional) [file_name]\n";
        return 1;
    }

    if (argc > 2) {
        if (argv[1][0] != '-') {
            std::cerr << "Usage [ccwc] [-flag] (optional) [file_name]\n";
            return 1;
        }

        if (std::strcmp(argv[1], "-c") == 0) {
            std::ifstream f;
            f.open(argv[2], std::ios_base::in | std::ios_base::ate);
            std::cout << std::setw(10) << get_count_of_bytes(f) << " " << argv[2] << '\n';
            f.close();
        } else if (std::strcmp(argv[1], "-l") == 0) {
            std::ifstream f;
            f.open(argv[2], std::ios_base::in);
            std::cout << std::setw(10) << get_count_of_lines(f) << " " << argv[2] << '\n';
            f.close();
        } else if (std::strcmp(argv[1], "-w") == 0) {
            std::ifstream f;
            f.open(argv[2], std::ios_base::in);
            std::cout << std::setw(10) << get_count_of_words(f) << " " << argv[2] << '\n';
            f.close();
        } else if (std::strcmp(argv[1], "-m") == 0) {
            std::cout << std::setw(10) << get_count_of_chars(argv[2]) << " " << argv[2] << '\n';
        }
    } else {
        std::ifstream f;
        f.open(argv[1], std::ios_base::in);
        std::cout << std::setw(10) << get_count_of_lines(f);
        f.seekg(0, std::ios_base::beg);
        std::cout << std::setw(10) << get_count_of_words(f);
        f.seekg(0, std::ios_base::beg);
        std::cout << std::setw(10) << get_count_of_bytes(f) << " " << argv[2] << '\n';
        f.close();
    }

    return 0;
}
