typedef struct {
    void (*set_name)(int hash, const char *);
    char *(*get_name)(int hash);
    void (*set_capacity)(int hash, long capacity);
    long (*get_capacity)(int hash);
    void (*set_average)(int hash, double average);
    double (*get_average)(int hash);
    void (*to_string)(int hash);
    int hash;
} stock;

stock *create_stock(char *name, long capacity, double average);
void destroy_stock(stock *s);
