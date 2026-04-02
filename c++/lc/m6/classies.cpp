#include <iostream>


class Log {

    public:
        enum Level {
            LevelError = 0, LevelWarning = 1, LevelInfo = 2
        };

    private:
        Level m_LogLevel = LevelInfo;

    public:
        void setLevel(Level level) {
            m_LogLevel = level;
        }
        
        void Warn(const char *msg) {
            if (m_LogLevel >= LevelWarning)
            std::cout << "\033[33m[WARNING]: \033[0m" <<  msg << "\n";
        }

        void Error(const char *msg) {
            if (m_LogLevel >= LevelError)
            std::cout << "\033[33m[ERROR]: \033[0m" <<  msg << "\n";
        }

        void Info(const char *msg) {
            if (m_LogLevel >= LevelInfo)
            std::cout << "\033[33m[INFO]: \033[0m" <<  msg << "\n";
        }
};


int main() {
    Log log;
    log.setLevel(log.LevelWarning);
    log.Warn("Hello!");
    log.setLevel(log.LevelError);
    log.Error("Error");
    log.setLevel(log.LevelInfo);
    log.Info("Info");

    return 0;
}
