# Device Driver Install Manual

## Prerequisites
* Kernel Source
* dtc (Device Tree Compiler)
* GCC 4.9.2 (to matching for running linux kernel image)

### Getting Kernel Source
Install "rpi-source" software.  
The "rpi-source" command automaticaly downloads the kernel source that matched running linux kernel version.

https://github.com/notro/rpi-source/wiki

to install:

    sudo wget https://raw.githubusercontent.com/notro/rpi-source/master/rpi-source -O /usr/bin/rpi-source && sudo chmod +x /usr/bin/rpi-source && /usr/bin/rpi-source -q --tag-update

### Getting dtc (Device Tree Compiler) package
Install dtc by package system.

    sudo apt-get install device-tree-compiler

### Install bc command
If bc is not installed, must install bc.

    sudo apt-get install bc

### Getting GCC-4.9.2 package (Kernel Version : ~ 4.1.17+)
Install GCC-4.9.x by package system.

    sudo apt-get install gcc-4.9 g++-4.9

Change default GCC.

    sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-4.9 10

## Driver Install

### 1. Get the kernel source

Choose place of kernel source files & directory, e.g. '.' current folder.

    rpi-source -d .

### 2. Pull driver source files

T.B.D.

### 3. Build & Install driver & dtb (device tree blob)

    cd ./I-Sabre-Q2M
    make
    sudo make modules_install
    make dtbs
    sudo make install_dtbo

### 4. Change /boot/config.txt

Add following lines.

    dtoverlay=i-sabre-q2m
    dtparam=i2c_arm=on

### 5. Reboot Raspberry Pi

### 6. Check driver is normaly installed

Use aplay -l command to check audio card is added.

    aplay -l

Installed audio card is follows.

    card xxx: DAC [I-Sabre Q2M DAC], device 0: I-Sabre Q2M DAC i-sabre-q2m-dai-0 []
