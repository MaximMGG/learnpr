#include <iostream>
#include <fstream>



int main() {
    
    char c;

    std::streampos pos_begin, pos_end;
    std::string line;
    std::fstream io("./word.txt");

    pos_begin = io.tellp();
    std::cout << "Begins pos: " << pos_begin << '\n';
    std::getline(io, line);

    std::cout << line << '\n';

    io << '\n';
    io << "Hello world!";
    io << "New line\n";

    io.seekp(0, std::ios::end);
    io << "New too line\n";
    io << "One more line";

    pos_end = io.tellp();

    std::cout << "End pos: " << pos_end << '\n';
    io.close();

    return 0;
}
