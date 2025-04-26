#include <linux/init.h>
#include <linux/module.h>

static int __init silent_init(void) {
    printk(KERN_INFO "Hello, world!\n");
    return 0;
}
static void __exit silent_exit(void) {
    printk(KERN_INFO "Goodbye, world!\n");
}

module_init(silent_init);
module_exit(silent_exit);

MODULE_LICENSE("GPL");


// What is this exit? where/from where
// why in minimul code license here
// why input return value and exit not?
// Can we remove __init and __exit
