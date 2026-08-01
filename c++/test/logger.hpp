



namespace log {

#define DEF_LOG_LOC nullptr, __LINE__, __FUNCTION__

  void info(const char *fmt, ...);
  void debug(const char *fmt, ...);
  void error(const char *fmt, ...);
  void fatal(const char *fmt, ...);
};
