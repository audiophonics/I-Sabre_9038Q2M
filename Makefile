KERNEL_SRC = /lib/modules/$(shell uname -r)/source
BUILD_DIR := $(shell pwd)
DTC_DIR = /lib/modules/$(shell uname -r)/build/scripts/dtc/
VERBOSE = 0

OBJS    = i-sabre-codec.o i-sabre-q2m.o

obj-m := $(OBJS)

all:
	make -C $(KERNEL_SRC) SUBDIRS=$(BUILD_DIR) KBUILD_VERBOSE=$(VERBOSE) modules

clean:
	make -C $(KERNEL_SRC) SUBDIRS=$(BUILD_DIR) clean
	rm -f i-sabre-q2m-overlay.dtb
	rm -f i-sabre-q2m.dtbo

dtbs:
	$(DTC_DIR)/dtc -@ -I dts -O dtb -o i-sabre-q2m-overlay.dtb i-sabre-q2m-overlay.dts
	$(DTC_DIR)/dtc -@ -H epapr -I dts -O dtb -o i-sabre-q2m.dtbo i-sabre-q2m-overlay.dts

modules_install:
	cp i-sabre-codec.ko /lib/modules/$(shell uname -r)/kernel/sound/soc/codecs/
	cp i-sabre-q2m.ko /lib/modules/$(shell uname -r)/kernel/sound/soc/bcm/
	depmod -a

modules_remove:
	rm /lib/modules/$(shell uname -r)/kernel/sound/soc/codecs/i-sabre-codec.ko
	rm /lib/modules/$(shell uname -r)/kernel/sound/soc/bcm/i-sabre-q2m.ko
	depmod -a

install:
	modprobe i-sabre-codec
	modprobe i-sabre-q2m

remove:
	modprobe -r i-sabre-q2m
	modprobe -r i-sabre-codec

# Kernel 4.1.y
install_dtb:
	cp i-sabre-q2m-overlay.dtb /boot/overlays/

# Kernel 4.4.y
install_dtbo:
	cp i-sabre-q2m.dtbo /boot/overlays/

remove_dtb:
	rm -f /boot/overlays/i-sabre-q2m-overlay.dtb
	rm -f /boot/overlays/i-sabre-q2m.dtbo
