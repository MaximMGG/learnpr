#include <iostream>
#include <string.h>

using namespace std;

#ifdef OLD_STR

char *gues_word(char *word) {
    char s_b[1000];
    memset(s_b, 0, 1000);
    int w_len = strlen(word);
    for(int i = 0; i < w_len; i++) {
        for(char c = 'A'; c <= 'z'; c++) {
            if (c == word[i]) {
                s_b[i] = c;
                break;
            }
        }
    }
    int b_len = strlen(s_b);
    char *res = (char *) malloc(sizeof(char) * b_len + 1);
    strcpy(res, s_b);
    return res;
}

#endif

// #define NEW_STR
#ifdef NEW_STR

std::string gues_word(std::string word) {
    char buf[1000];
    for(int i = 0; i < word.size(); i++) {
        for(char c = 'A'; i <= 'z'; c++) {
            if (c == word.data()[i]) {
                buf[i] = c;
                break;
            }
        }
    }
    std::string s_b{buf};

    return s_b;
}

#endif


int main() {

    // cout.setf(ios_base::boolalpha);
    // cout << (1 > 2) << endl;
    // cout.setf(ios_base::fixed);
    // double a {1231234123.23424};
    // cout << a << endl;

#ifdef OLD_STR
    char *guesed_word_c = new char[1000];
    strcpy(guesed_word_c, "qqqqqqqqqqqqqwwwwwwwwwwwweeeeeeeeeeeeerrrrrrrrrrrrrrrrttttttttttttttttttyyyyyyyyyyyyyyyyyyyyuuuuuuuuuuuuuuuuuuiiiiiiiiiiiiiiiiioooooooooooooooopppppppppppppp");
    char *res_c = gues_word(guesed_word_c);

    std::cout << res_c << std::endl;
#endif

#ifdef NEW_STR

    std::string guesed_wrd_s{"qqqqqqqqqqqqqwwwwwwwwwwwweeeeeeeeeeeeerrrrrrrrrrrrrrrrttttttttttttttttttyyyyyyyyyyyyyyyyyyyyuuuuuuuuuuuuuuuuuuiiiiiiiiiiiiiiiiioooooooooooooooopppppppppppppp"};
    std::string res_s = gues_word(guesed_wrd_s);


    std::cout << res_s << std::endl;
#endif

    std::string mx{"jkahsdkfjhasdjfhdjfhfdjjjjjjjjjjjjjjjjjjjfffffffffffffffffffffffffffff1ffffffffffffffffffffffff2ffffffffffffffffffffffff3fffffffffffffffffff4ffffffffffffffffffffff5lllllllllllllffffffffff7ffffffff8"};
    std::cout << mx.max_size() << std::endl << mx << std::endl;

    return 0;
}
