#!/bin/bash

RED='\033[0;31m'	# Red Color
NC='\033[0m'		# No Color

read -p $'\e[31m>>> Perform system update and upgrade first? (Reboot required) \e[0m' -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]
then
	sudo apt-get update && sudo apt-get upgrade -y && sudo apt-get install git
	sudo reboot
fi

echo -e "${RED}>>> No update. Installing development packages in 5 seconds.${NC}"
sleep 5

sudo apt install unzip libudev-dev automake autoconf gobjc libsdl2-dev libsdl1.2-dev -y

echo -e "${RED}>>> Downloading GMP in 5 seconds.${NC}"
sleep 5

# GMP for Kanjitalk755 Version

mkdir -p ~/Downloads
wget https://ftp.gnu.org/gnu/gmp/gmp-6.2.1.tar.xz -O - | tar -xf -C ~/Downloads

echo -e "${RED}>>> Compiling and installing GMP in 5 seconds...this may take a few moments...${NC}"
sleep 5

# GNU

cd ~/Downloads &&

cd gmp-6.2.1
./configure --disable-shared
sudo make
sudo make check
sudo make install

echo -e "${RED}>>> Downloading MPFR in 5 seconds.${NC}"
sleep 5

# MPFR for Kanjitalk755 Version

wget https://www.mpfr.org/mpfr-current/mpfr-4.2.2.tar.xz -O - | tar -xf -C ~/Downloads

echo -e "${RED}>>> Compiling and installing MPFR in 5 seconds...this may take a few moments...${NC}"
sleep 5

# MPFR

cd ~/Downloads &&

cd mpfr-4.2.2
./configure --disable-shared
sudo make
sudo make check
sudo make install

echo -e "${RED}>>> Downloading Basilisk II in 5 seconds.${NC}"
sleep 5

cd ~
git clone https://github.com/kanjitalk755/macemu

echo -e "${RED}>>> Compiling and installing Basilisk II in 5 seconds.${NC}"
sleep 5

cd macemu/BasiliskII/src/Unix
./autogen.sh
sudo make
sudo make install

echo -e "${RED}>>> Setting up some Basilisk II preferences.${NC}"

echo "rom /home/pi/Quadra800.ROM
disk /home/pi/HD500.dsk
displaycolordepth 8
seriala /dev/ttyS0
serialb /dev/ttyS1
udptunnel false
bootdrive 0
bootdriver 0
ramsize 142606336
frameskip 0
modelid 14
cpu 4
fpu true
nocdrom false
nosound false
noclipconversion false
nogui false
jit false
jitfpu false
jitdebug false
jitcachesize 0
jitlazyflush false
jitinline false
keyboardtype 5
keycodes false
mousewheelmode 1
mousewheellines 3
hotkey 0
scale_nearest false
scale_integer false
yearofs 0
dayofs 0
swap_opt_cmd true
ignoresegv true
soundbuffer 0
name_encoding 0
init_grab false
dsp /dev/dsp
mixer /dev/mixer
idlewait true
ether slirp
screen win/800/600" | tee -a ~/.basilisk_ii_prefs

cd ~
unzip rpi5-basiliskii/HD500.zip -d /home/pi
cp rpi5-basiliskii/Quadra800.ROM .
cp rpi5-basiliskii/startup.wav .

echo -e "${RED}>>> Done. Starting BasiliskII...${NC}"
sleep 5

BasiliskII
