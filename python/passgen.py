import random

TOTAL_LEN = 16
CURRENT_LEN = 0

TABLE = [
"QWERTYUIOPASDFGHJKLZXCVBNM",
"qwertyuiopasdfghjklzxcvbnm",
"!@#$%^&*()_{}\"',./?|\\",
"1234567890"]




while CURRENT_LEN < TOTAL_LEN:
    index = random.randint(0, TABLE.__len__() - 1)
    char = TABLE[index][random.randint(0, TABLE[index].__len__() - 1)]
    print(char, end='')
    CURRENT_LEN += 1

print()

