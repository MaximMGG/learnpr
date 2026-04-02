#include <assert.h>
#include <stdlib.h>

int tmult64_ok(int64_t x, int64_t y) {

}


int tmult_ok(int x, int y) {
    int res = x * y;

    return !x || res / x == y;
}

void multtest() {
    int x = 0;
    int y = 20000000;
    assert_true(tmult_ok(x, y), "Overmult");
}


int main() {

    assert_begin(ASSERT_SHOW_FUNC | ASSERT_SHOW_FUNC_TIME | ASSERT_SHOW_TOTAL_TIME | ASSERT_SHOW_ASSERT_MSG);
    assert_coll(multtest);
    assert_end();


    return 0;
}
