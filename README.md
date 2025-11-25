# Raspberry Pi 5 - Load and Run Script

Forked from Ekbann's script, this script will automatically download and compile all the necessary source code to have a fully functional Basilisk II emulator running with SDL2 and without X Windows for maximum performance on a Raspberry Pi 4/5 and has been tested with a Raspberry Pi Zero W, with a few extra steps. The purpose of this project is to create a self contained emulator that runs by itself in order to create reproductions of old Macs using modern hardware.  It containe a working ROM, and a basic MacOS 7.6 Hard Drive Image.  The MacOS 7.6 is also updated to OpenTransport 1.3, and AppleShare 3.8.3. There are two options a available in this build:

First is the run.sh script that will load a working Basilisk II without using X11 or a desktop enivornment.  This is for use with exisitng Raspberry Pi installations.  ((Disclaimer:  I'm not a coder; I'm a hardware guy.  Backup your exisiting installations first, before applying this if you want to make sure they do not become corrupted.))

The second is a full image that is downloadable, and will boot with a blank screen, play a startup chime, and go directly into Basilisk II.  Upon selecting Shut Down inside MacOS, the Pi will shut itself down.  There will be an explanation below on how to access "rasp-config" in order to setup your Wifi, and SSH keys.  These images use audio over the HDMI cable.

The following have been used in this build:

    Raspberry Pi OS Lite 64-bit & 32-bit Trixie
    Raspberry Pi OS Lite 64-bit & 32-bit Bookworm
    Raspberry Pi 5
    Raspberry Pi 4
    Raspberry Pi Zero W
    Basilisk II version by kanjitalk755
    SDL2
    MPFR
    GNU

The default screen is set to 800 x 600 with a 68040 processor, and 64mb of RAM.  The ethernet is slirp which works with the onboard wifi.

**Option #1 - run.sh**

To install using the script, boot into your Raspberry Pi OS Lite.  This script assumes that your username is "pi" Once your OS is loaded, and you are sitting at the prompt run the following commands:

    sudo apt install git
    git clone https://github.com/RedPhantom07/rpi5-basiliskii
    cd rpi5-basiliskii
    bash run.sh

The first option the script offers you is to an update and upgrade on your current distribution, by typing "Y."  This will not upgrade to a newer version of the OS, so if you are using Bookworm, it stays on Bookworm.  ((It will also install git, if you skipped the last step, and just copied the script and files locally.))

If you choose the update, it will force a reboot, and then you will have to wait until the OS loads again, and then:

    bash run.sh

This time, type "N" and the installation will continue.  The script will load GMP, and the MPFR, as recommended by Kanjitalk755.  After that it will download Basilisk II from Kanjitalk755's github, decompress the HD, and copy the HD, the ROM, and startup.wav to /home/pi.

When the script ends, it will run Basilisk II automatically but you can also manually start with the commands below. Enjoy!
    
You can change the screen resolution by editing the .basilisk_ii_prefs, by typing:

    sudo nano ~/.basilisk_ii_prefs

and change the "screen" parameters to:

    displaycolordepth 16
    screen win/1024/768
    
Then go to Mac OS 7.6 Control Panel and under Monitors, select "Thousands" of colors.

Ekbann included a folder called "keyboard." Per his words, it has "the default raw keycodes used by Basilisk II. Basically it converts the host OS scancodes into the emulated Basilisk II keycodes. This allows the ALT and WINDOWS keys to be assigned the COMMAND and OPTION keys respectively. There are many keycode sets depending on which video driver is being used, e.g. X11, Quartz, Linux framebuffer, Cocoa, or Windows. This is especially needed when using non-QWERTY keyboard layouts."

A few other import notes concerning the prefs file:

extfs is turned off by default.  This would create a second hard drive on the MacOS desktop that would let you browse your files on the Pi OS side, and copy files directly to the MacOS.  This was done to create the illusion of a stock MacOS, but it can be reenabled by editing the prefs file, and removing the line:

    extfs

Once removed, the Unix Drive will appear on the desktop again.

If you have your own drive that you want to use, perhaps from another Emulator, you need only modify the disk line:

    disk /home/pi/HD500.dsk

Simply replace "/home/pi/HD500.dsk" with the path to your own drive, formatted the same way.  Ex. /path/to/my/drive

When you first start MacOS, you should take a moment to go to the TCP/IP control panel, and start it up to using TCP/IP.  Just click Yes, and then close the control panel.  You can also go into Monitors and change the number of colors being displayed.

While the startup.wav, (which is the bong from the early 90s Macs) was included with the repo, it is not used with the launch of Basilisk II.  It is provided in case you wish to do further modification to get it to launch.  If you continue reading in Option 2, you will see that provide some information as to how I created the image, and you may find some information if you want to adapt part of it to your new installation, including using startup.wav.

**Option 2 - Full Image**

The full images are provided as an option if you are trying to build a retro looking Classic Mac, but wanted to use modern hardware to do it.  The images provided can be flashed to flash card using something like Rufus, or balenaEtcher.  It will take the image, and make the copy, and then when you put it into the Raspberry Pi, turn the Pi on, you will see a black screen, then hear a Mac boot chime, and Basilisk II will autoload into the MacOS 7.6 desktop.

When you first start MacOS, you should take a moment to go to the TCP/IP control panel, and start it up to using TCP/IP.  Just click Yes, and then close the control panel.  You can also go into Monitors and change the number of colors being displayed.  If you choose Shut Down from the Special Menu, it will shut down the Pi as well, which will display a black screen until you remove power to the Pi.

MORE TO COME...
