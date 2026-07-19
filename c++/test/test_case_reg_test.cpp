

void registerTestCase(const char *test_name, void (*test_func)()) {
  
}


#define TEST_BEG(test_case) void test_case() {    \
  registerTestCase(#test_case, test_case); 

#define TEST_END }

#define TEST_CASE(test_name, code) void test_name() { \
  registerTestCase(#test_name, test_name);   \
  {code}                                   \
}   \

