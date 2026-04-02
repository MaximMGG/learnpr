#include <iostream>
#include <fstream>
#include <map>
#include <string>
#include <cstring>

bool add_key_val(std::map<std::string, std::string> &io, char *buf, int &pos) {
    int buf_len = std::strlen(buf);
    char tmp_k[512]{0};
    char tmp_v[512]{0};
    int tmp_i = 0;

    while(buf[pos] == ' ' || buf[pos] == '\n') {
        pos++;
    }

    for( ; pos < buf_len; pos++) {
        if (buf[pos] == ' ' && tmp_i != 0) {
            break;
        }
        tmp_k[tmp_i++] = buf[pos];
    }

    pos += 3;
    tmp_i = 0;
    for ( ; pos < buf_len; pos++) {
        if (buf[pos] == '\n' || buf[pos] == ' ') {
            break;
        }
        tmp_v[tmp_i++] = buf[pos];
    }

    io[tmp_k] = tmp_v;
    if (pos >= buf_len) {return false;}
    return true;
}


int main() {

    std::cout << "Start app\n";

    std::fstream in("./word.txt");

    char buf[512]{0};
    in.read(buf, 512);

    const char *msg = "HEllo world";

    std::map<std::string, std::string> io;

    std::cout << buf << '\n';

    int p = 0;
    
    while(add_key_val(io, buf, p));

    std::strcpy(buf + std::strlen(buf), msg);

    for(auto i = io.begin(); i != io.end(); i++) {
        std::cout << "Key: " << i->first << ", value: " << i->second << '\n';
    }
    std::cout << "msg: " << buf << '\n';

    in.write(buf, std::strlen(buf));

    in.close();
    std::cout << "End app\n";

    return 0;
}
