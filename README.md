# Raspberry Pi 5 - Load and Run Script

Forked from Ekbann's script, this script will automatically download and compile all the necessary source code to have a fully functional Basilisk II emulator running with SDL2 and without X Windows for maximum performance on a Raspberry Pi 4/5 and has been tested with a Raspberry Pi Zero W, with a few extra steps. The purpose of this project is to create a self contained emulator that runs by itself in order to create reproductions of old Macs using modern hardware.  It containe a working ROM, and a basic MacOS 7.6 Hard Drive Image.  The MacOS 7.6 is also updated to OpenTransport 1.3, and AppleShare 3.8.3. 

I would recommend at least 8 GB SD cards for these builds.

All images have the standard username, and password:

    user:  pi
    pass:  raspberry

There are two options a available in this build:

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

## Option #1 - run.sh

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

### There are a few additional steps for the Pi Zero W.

First, fair warning.  It's going to take the better part of two (2) hours to download and compile everything. The Pi Zero W is not fast, which is why you may want to think about the image file.  That being said, if you go through with it, then you may have to configure the audio out of the Pi Zero, as for some reason it does not always do so by itself.  I would suggest testing the sound in Basilisk II first, but if you hear the chime during boot, that is a good indication it is working.  After much deep diving, the best way I have found to do this as of Bookworm (2025) is to edit the following file:

    sudo nano ~/.asoundrc

Alsa is the main way we use sound on Raspberry Pi, and we have to edit this file in order to recognize the HDMI on the Pi Zero W.  If you are using a different audio out, you will have to do a little more of your own digging, but it certainly is possible.  Once you have the file open, replace everything in the file with the following:

    pcm.!default {
    type plug
    slave.pcm "sysdefault:CARD=vc4hdmi"
    }

    ctl.!default {
    type hw
    card 0
    }

Restart the pi afterwards:

    sudo reboot

You can either start Basilisk II and test sound in there, or you can try playing the included startup.wav.

    aplay /home/pi/startup.wav

As of 2025 this should produce sound.

## Option 2 - Full Image

I've created the following images, the RPi 4 and 5 are 64-bit, the Pi Zero W is 32-bit.

[Raspberry Pi 5](https://mega.nz/file/nZNk3SQI#DcxHI7vfAH5r08z_-juWvIYC53ATVZ_zixup0g0DFYA)
[Raspberry Pi 4](https://mega.nz/file/GNl2BTZD#sx14Gmyuj1iyIdsTa6NRzUgxTT23gPr59oAnTODHYrw)

[Raspberry Pi Zero W](https://mega.nz/file/bAESHQhZ#KDwYhBMXaxASzUaA1jEdsEeDxDEfXE9nW0epCpWhCBE)

The full images are provided as an option if you are trying to build a retro looking Classic Mac, but wanted to use modern hardware to do it.  The images provided can be flashed to flash card using something like Rufus, or balenaEtcher.  It will take the image, flash it to the SD card, and then when you put it into the Raspberry Pi, turn the Pi on, you will see a black screen, then hear a Mac boot chime, and Basilisk II will autoload into the MacOS 7.6 desktop.

When you first start MacOS, you should take a moment to go to the TCP/IP control panel, and start it up to using TCP/IP.  Just click Yes, and then close the control panel.  You can also go into Monitors and change the number of colors being displayed.  If you choose Shut Down from the Special Menu, it will shut down the Pi as well, which will display a black screen until you remove power to the Pi.

The image for the Raspberry Pi Zero W is probably a faster way to do the Pi Zero W, as the download and configuration through the script can take almost two hours.

#### Flashing to an SD Card:

Unzip your choice of image, and locate the .img file.  If you are using Balena Etcher, the first step is selecting the image.  Click "Select Image" and locate the .img file you just uncompressed.  Next make sure you have a SD card ready to go.  You need at least an 8 GB card so that the entire image will fit.  In Balena Etcher, click "Select Target" and then select the drive containing the SD card.  Finally click "Flash!"  The process will take a little while to complete.  First you will see a progress bar for flashing, and then it will be followed by a progress bar for Verifying.  Once the flash is complete, it will unmount the SD card, and it should be ready to go to insert into the Pi.

On first boot of the Pi, the SD card contains a script that will automatically expand the file storage to include the rest of the space on the card.  When it does that, it will automatically reboot, so do not be surprised if the first run takes a little bit longer than normal, especially on the Pi Zero.  During this time, as it has been configured, the screen will remain black.  (My monitor will display resolution changes and updates every so often, so that is how I can tell that it is continuing with the process.)  Eventually, the system will finish, and you should hear a Mac chime, and see a desktop load in Basilisk.  Depending on the model that you have, you may or may not see the OS loading screen.  The Pi 5 seems to load straight to desktop pretty quickly.  Once the desktop is loaded, you can proceed to the next step to add networking, or if you wish to leave it as a standalone, then you are finished, Enjoy!

#### Updating you WiFi Settings:

I hope to find a better way to do this.  In the old days, you could add a wpa_supplicant.conf to the root directory, with your WiFi information, and it would configure the WiFi automatically on the Pi for you.  Since they swtiched to cloud_init though in Bookworm, that process has changed, so for the moment, here is the route I use.  I left the SSH port open on each image.  If you are using a Pi 4 or Pi 5, then you can attach a hardwire to the network port, and then using a program to see the devices on your network, you should be able to see the device.  (Note:  Please make sure to shutdown from Basilisk, before doing this.  It should return you to a black screen.)  Using a terminal window you can access the Pi using the following command:

    ssh pi@<ipaddress of pi>

It will then prompt you for the password, which is:

    raspberry

You should then see a standard command line on your terminal window.  Next, enter the following:

    sudo raspi-config

This will bring up the normal Raspberry Pi setup window.  By choosing option "1" you can then scroll down, to the WiFi setting and setup your WiFi for wireless networking.

#### Having Basilisk II Shutdown your Pi:

Finally, while you are still inside the SSH you can change one option to let Basilisk shutdown your Pi, when you choose Shut Down in the Special Menu.  This will require editing an exisitng file.  WARNING:  By editing this file, you will be unable to make other changes to the installation without the use of another Linux machine.  By taking the following steps, the Pi will shutdown whenever Basilisk quits, exits, crashes, or ends in anyway.

The first step, is by opening the file:

    sudo nano /etc/systemd/system/basilisk.service

If you scroll down through the file, you should see the line:

     # Shutdown Pi when Basilisk exits, currently disabled, remove the # before Exec to turn on
     #ExecStopPost=sudo shutdown -h now

Simply delete the "#" next to ExecStopPost, so that it looks like this:

    ExecStopPost=sudo shutdown -h now

Hit Ctrl+X, to exit the document, and then "Y" to save the file.  Follow that, by typing the following commands:

    sudo systemctl daemon-reload
    sudo systemctl enable basilisk.service

This will reload the service.  This has now become somewhat permament, meaning the only way to change it back, would be to edit the file itself on another Linux computer to add the "#" back in, because there will be no further way to access the command line while Basilisk is running, and when you exit Basilisk, it shut downs the Pi.


## How to Make Your Own Version - Follow Up to Option 1

In case you are interested in modifying your installation (or your image), here are some of the methods I used to achieve this.  Again, I'm not a software guy, and I wanted something that worked.  If there is a more efficient version, I am all ears.  There is also no guarantee that this will work for you either, as Linux can be...difficult at times...as well as new updates change, and break old things.  IT IS RECOMMENDED THAT YOU KEEP SSH ENABLAED, BECAUSE ONCE WE START CHANGING THINGS, YOU WILL NOT BE ABLE TO MODIFY SETTINGS ON THE PI ITSELF.

### Raspberry Pi 4/5

First, to let the Raspberry Pi boot straight into Basilisk II, you have to create a service to do that.  A service loads with the rest of the OS.  The following is based on the installation of the script, (and the image.)  Again this assumes that your using the user "pi."

The first step is to create the service file itself:

    sudo nano /etc/systemd/system/basilisk.service

This will open the text editor, and then you want to put in the following:

    [Unit]
    Description=Basilisk II Emulator
    After=multi-user.target
    Wants=multi-user.target

    [Service]
    Type=simple
    User=pi
    WorkingDirectory=/home/pi
    ExecStartPre=aplay /home/pi/startup.wav
    ExecStart=/usr/local/bin/BasiliskII

    # Shutdown Pi when Basilisk exits, currently disabled, remove the # before Exec to turn on
    #ExecStopPost=sudo shutdown -h now

    StandardInput=tty
    StandardOutput=null
    TTYPath=/dev/tty1
    Environment=SDL_VIDEODRIVER=kmsdrm
    Environment=KMSDRM_REQUIRE_DRM_MASTER=1

    [Install]
    WantedBy=multi-user.target

This creates a startup service for Basilisk II, and if you notice, will also play the startup chime before the Program starts.  It also removes the text you see when Basilisk II normally starts.  This is accomplished with "StartupOutput=null"  You need to update the service field by typing:

    sudo systemctl daemon-reload
    sudo systemctl enable basilisk.service

This is only the first step though, because, you still have a good deal of text during the boot up sequence.  Well there are two more steps to that.  The next step involves modifying cmdline.txt.  To do this:

    sudo nano /boot/firmware/cmdline.txt

Unless you have already modified this yourself, you will want to remove the following:

    console=tty01

And then add in:

    quiet splash loglevel=0 vt.global_cursor_default=0

This removes the reporting to the console of the boot sequence, and adds "quiet", "splash", "loglevel=0", and "vt.global_cursor_default=0"  The last flag removes the blinking cursor, including at the command line level.  

The last step is to remove the login prompt.  You can configure this in "raspi-config" by choosing Option 1, and turning on Auto Login.  But wait, there is more.  We also have to edit another file to get rid of all that annoying text.  To do this, go back to the command line, and type:

    sudo systemctl edit getty@tty1.service

Most of this file will be commented out, however at the top of the file you will see the lines:

    ### Editing /etc/systemd/system/getty@tty1.service.d/override.conf
    ### Anything between here and the comment below will become the contents of the drop-in file

Then several lines of blank spaces, followed by:

    ### Edits below this comment will be discarded

In between these two lines you want to add the following, so it looks like this when you are done:

    ### Editing /etc/systemd/system/getty@tty1.service.d/override.conf
    ### Anything between here and the comment below will become the contents of the drop-in file

    [Service]
    ExecStart=
    ExecStart=-/sbin/agetty --autologin pi --noclear --noissue --login-options "--silent" tty1 linux
    Type=oneshot

    ### Edits below this comment will be discarded

Once you close this, you are ready to proceed.  If you have done all of these things, and saved them along the way, you should be ready to proceed.  Restart your pi.

    sudo reboot

Assuming everything went well, the Pi should reboot, and keep a black screen, until you hear a chime, and watch Basilisk II startup.  If you are happy, and everything is working, then you can go back to the service and edit it to turn off the Pi when you close down Basilisk II.

    sudo nano /etc/systemd/system/basilisk.service

Then goto the line that says:

    #ExecStopPost=sudo shutdown -h now

Remove the "#" sign, save, and then type the following.

    sudo systemctl daemon-reload
    sudo systemctl enable basilisk.service

You should be all set.  HOWEVER, please note that once you do this, if you need to change anything you will have to do so by editing the files on another machine or VM where you can look at the directories and make changes.  I recommend waiting on the shutdown service, until you are 100% you are good to go.  The easiest way to get back in, would be to edit the "/etc/systemd/system/basilisk.service" on another machine or VM, and add the "#" back in.  When you shutdown Basilisk after that, you can still SSH in and make changes from there.

### Raspberry Pi Zero W

The process here is different than the 4/5 process, as the Zero works a little differently.  As you have seen above, we already had to make a change to get the sound to work on the device.  The upside is that it feels more like a retro computer consider it takes more time to load, and the RAM is much less, and closer to an older Mac.

First, to create a service so that Basilisk II starts up on boot, we have to do the following.  First:

    sudo nano /etc/systemd/system/basilisk.service

On the blank page, you will want to paste the following:

    [Unit]
    Description=Basilisk II Emulator
    After=getty@tty1.service
    Wants=sound.target

    [Service]
    Type=simple
    User=pi
    ExecStart=/bin/bash -c "sleep 25 && aplay /home/pi/startup.wav &&  /usr/local/bin/BasiliskII"
    StandardOutput=journal
    StandardError=journal

    [Install]
    WantedBy=multi-user.target

This creates a startup for Basilisk II, but it is by no means a quick process.  If you notice, in "ExecStart" we have a "sleep 25" which means its going to wait 25 seconds to activate Basilisk II.  This is for several reasons.  First, the Pi Zero W takes a while to boot and we need it load all of the main components for the graphics, and for the audio in order to use Basilisk II.  After experimenting with different wait times, this seems to be the quickest that it can be done, IF you want it to play the chime too.  If you care not, you can edit, the "25" and change it to "20", which is the fastest it can go without the chime.

The next thing we need to edit is the cmdline.txt, so that we can remove as much of the text during startup as we can.

    sudo /boot/firmware/cmdline.txt

Unless you have already modified this yourself, you will want to remove the following:

    console=tty01

And then add in:

    quiet splash loglevel=0 vt.global_cursor_default=0

You might also want to take a moment to remove the Pi Zero W splash screen:

    sudo /boot/firmware/config.txt

At the very bottom, you want to add:

    disable_splash=1

Finally, to create the last silent part of the boot, and get it to display only a black screen we need to change the following:

    sudo systemctl edit getty@tty1.service

Most of this file will be commented out, however at the top of the file you will see the lines:

    ### Editing /etc/systemd/system/getty@tty1.service.d/override.conf
    ### Anything between here and the comment below will become the contents of the drop-in file

Then several lines of blank spaces, followed by:

    ### Edits below this comment will be discarded

In between these two lines you want to add the following, so it looks like this when you are done:

    ### Editing /etc/systemd/system/getty@tty1.service.d/override.conf
    ### Anything between here and the comment below will become the contents of the drop-in file

    [Service]
    ExecStart=
    ExecStart=-/sbin/agetty --autologin pi --noclear --noissue --login-options "--silent" tty1 linux
    Type=oneshot

    ### Edits below this comment will be discarded

Once you close this, you are ready to proceed.  If you have done all of these things, and saved them along the way, you should be ready to proceed.  Restart your pi.

    sudo reboot

Assuming everything went well, the Pi should reboot, and keep a black screen, until you hear a chime, and watch Basilisk II startup.  If you are happy, and everything is working, then you can go back to the service and edit it to turn off the Pi when you close down Basilisk II.

I hope that found this useful.  You are more then welcome to ask questions, I'm not sure I'll have answers for you, but I'm always trying to give back to the community that has helped me do so much.
