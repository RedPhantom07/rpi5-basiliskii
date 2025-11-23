# Raspberry Pi 5 - Load and Run Script

Forked from Ekbann's script, this script will automatically download and compile all the necessary source code to have a fully functional Basilisk II emulator running with SDL2 and without X Windows for maximum performance. The purpose of this project is to create a self contained emulator that runs by itself in order to create reproductions of old Macs using modern hardware.  There are two options a available in this build.  

First is the run.sh script that will load a working Basilisk II without using X11 or a desktop enivornment.  It also containe a working ROM, and a basic MacOS 7.6 Hard Drive Image.

The second is a full image that is downloadable, and will boot with a blank screen, play a startup chime, and go directly into Basilisk II.  Upon selecting Shut Down inside MacOS, the Pi will shut itself down.

The following have been used in this build:

    Raspberry Pi OS Lite 64-bit Bookworm
    Raspberry Pi 5
    Basilisk II version by kanjitalk755
    SDL2
    MPFR
    GNU

The default screen is set to 800 x 600 with a 68040 processor, and 64mb of RAM.

To install using the script, boot into your freshly created Raspberry Pi OS Lite and login with the default user "pi" (password "raspberry"). Then run the following commands:

    sudo apt install git
    git clone https://github.com/RedPhantom07/rpi5-basiliskii
    cd rpi5-basiliskii
    bash run.sh

When the script ends, it will run Basilisk II automatically but you can also manually start with the commands below. Enjoy!
    
You can change the screen resolution by editing the .basilisk_ii_prefs and change the "screen" parameter. For some serious work, you can try the following:

    screen win/1024/768
    displaycolordepth 16

Then go to Mac OS 7.6.1 Control Panel and under Monitors, select "Thousands" of colors.

There is a folder called "keyboard" that has the default raw keycodes used by Basilisk II. Basically it converts the host OS scancodes into the emulated Basilisk II keycodes. This allows the ALT and WINDOWS keys to be assigned the COMMAND and OPTION keys respectively. There are many keycode sets depending on which video driver is being used, e.g. X11, Quartz, Linux framebuffer, Cocoa, or Windows. This is especially needed when using non-QWERTY keyboard layouts.
