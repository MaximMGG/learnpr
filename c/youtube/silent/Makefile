.PHONY: all
.SILENT: clean

CURRENT = $(shell uname -r)
KCOMPILER = $(shell grep CONFIG_CC_VERSION /boot/config-$(shell uname -r) | cut -d'"' -f2 | awk '{print $$1}')
KDIR = /lib/modules/$(CURRENT)/build
PWD = $(shell pwd)

TARGET = silent
obj-m := $(TARGET).o

all:
	$(MAKE) CC=$(KCOMPILER) -C $(KDIR) M=$(PWD) modules

clean:
	rm -f *.ko *.cmd .*.cmd *.mod .*.mod *.mod.* *.o *.order *.symvers
