#include <iostream>
#include <fstream>
#include <cstring>


int main() {

    const char *h = "hello";

    std::ofstream outFile;
    std::ifstream inFile;
    outFile.open("test.txt");
    if (outFile.is_open()) {
        outFile.write(h, strlen(h));
    }

    outFile.close();

    std::string line;
    std::getline(inFile, line);

    std::cout << line << '\n';

    inFile.close();
    return 0;
}
