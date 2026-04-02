#include <fstream>
#include <iostream>

#define EXIT_FAIL 1

int main() {
    //
    // std::ofstream outFile;
    // outFile.open("text.txt");
    // std::string filename;
    // getline(std::cin, filename);
    // outFile << filename;
    // outFile.close();
    //
    // std::ifstream inFile;
    // inFile.open("text.txt");
    // if(!inFile.is_open()) {
    //     exit(EXIT_FAIL);
    // }
    // std::string fromFile;
    // while(!inFile.eof()) {
    //     inFile >> fromFile;
    //     std::cout << fromFile << " ";
    // }
    // std::cout << std::endl;

    int x = 1;
    if (!!!x) {
        std::cout  << "Yes\n";
    }
    return 0;
}
