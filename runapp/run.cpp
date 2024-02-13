#include <cstdlib>
#include <iostream>
#include <vector>
#include <string>
#include <cstring>


static std::vector<std::string> executor;
static std::string pr_name;
static bool JUST_COMPILE = false;
static int ARGS_POS {0};

char *parse_program_name(char **argv) {
    int name_pos {1};
    if (JUST_COMPILE) {
        name_pos = 2;
    }
    int len = strlen(argv[name_pos]);
    char *buf = new char[len - 3];

    for(int i = 0; i < len; i++) {
        if (argv[name_pos][i] == '.') {
            buf[i] = '\0';
            break;
        }
        buf[i] = argv[name_pos][i];
    }
    pr_name = "./";
    pr_name += buf;
    return buf;
}

std::string prepare_execution(int argc, char **argv) {
    executor.push_back("g++ ");
    executor.push_back("-o ");
    char *pr_name_l = parse_program_name(argv);
    executor.push_back(pr_name_l);
    executor.push_back(" ");
    delete [] pr_name_l;

    int i {1};
    int end {argc};
    if (JUST_COMPILE) {
        i = 2;
    }
    if (ARGS_POS) {
        end = ARGS_POS - 1;
    }
    for( ; i < end; i++) {
        executor.push_back(argv[i]);
        executor.push_back(" ");
    }

    executor.push_back("-Wall ");
    executor.push_back("-Weffc++ ");
    executor.push_back("-Wextra ");
    executor.push_back("-Wconversion ");
    executor.push_back("-Wsign-conversion ");
    executor.push_back("-std=c++20 ");
    executor.push_back("-g ");

    std::string exe {""};
    for(size_t i = 0; i < executor.size(); i++) {
        exe += executor[i];
    }

    return exe;
}

static void prepare_pr_args(int argc, char **argv) {
    if (ARGS_POS == 0) {
        return;
    }
    for(int i = ARGS_POS; i < argc; i++) {
        pr_name += " ";
        pr_name += argv[i];
    }
}

static void set_flags(int argc, char **argv) {
    for(int i = 1; i < argc; i++) {
        if (strcmp(argv[i], "c") == 0) {
            JUST_COMPILE = true;
        }
        if (strcmp(argv[i], "-a") == 0) {
            ARGS_POS = i == argc - 1 ? 0 : i + 1;
        }
    }
}


int main(int argc, char **argv) {
    if (argc <= 1) {
        std::cerr << "Enter the file name\n";
        return 1;
    }
    set_flags(argc, argv);
    std::string exe = prepare_execution(argc, argv);
    prepare_pr_args(argc, argv);
    system(exe.data());
    if (!JUST_COMPILE) {
        system(pr_name.data());
    }

    return 0;
}
