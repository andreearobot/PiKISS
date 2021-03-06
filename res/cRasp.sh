#!/bin/bash
#
# Description : Personal script to make my custom Raspbian
# Author      : Jose Cerrejon Gonzalez (ulysess@gmail_dot._com)
# Version     : 1.3 (26/May/15)
# Compatible  : Raspberry Pi 1 & 2 (tested)
#
# Best method to get, SSH into RPi and: wget -O pre.sh https://goo.gl/qQ3JDv && chmod +x pre.sh && ./pre.sh
#
clear

sudo apt-get update && sudo apt-get dist-upgrade -y
sudo apt-get install -y mc htop apt-file unrar-free
sudo apt-get remove -y wolfram-engine


# Some useful alias
sed -i "/# Alias definitions/i\alias upd='sudo apt-get update && sudo apt-get dist-upgrade -y && sudo apt-get autoremove -y && sudo apt-get clean && sudo apt-get autoclean'" $HOME/.bashrc
sed -i "/# Alias definitions/i\alias reboot='sudo reboot'" $HOME/.bashrc
sed -i "/# Alias definitions/i\alias ins='sudo apt-get install -y '" $HOME/.bashrc
sed -i "/# Alias definitions/i\alias halt='sudo halt'" $HOME/.bashrc
sed -i "/# Alias definitions/i\alias rm='sudo rm -rf '" $HOME/.bashrc

# autologin
sudo sed -i '/1:2345/s/^/#/' /etc/inittab
sudo sed -i 's/.*tty1.*/&\n1:2345:respawn:\/bin\/login -f pi tty1 <\/dev\/tty1> \/dev\/tty1 2>\&1/' /etc/inittab

# Fix SDL
wget -P /tmp http://malus.exotica.org.uk/~buzz/pi/sdl/sdl1/deb/rpi1/libsdl1.2debian_1.2.15-8rpi_armhf.deb
sudo dpkg -i /tmp/libsdl1.2debian_1.2.15-8rpi_armhf.deb
sudo rm /tmp/libsdl1.2debian_1.2.15-8rpi_armhf.deb

# Disable partition "swap"
sudo dphys-swapfile swapoff
sudo dphys-swapfile uninstall
sudo update-rc.d dphys-swapfile remove

# Avoid SD corruption
sudo sed -i 's/atime/noatime,nodiratime/g' /etc/fstab

# Automatic fsck on start
#sudo sed -i 's/#FSCKFIX=no/FSCKFIX=yes/g' /etc/default/rcS && grep "FSCKFIX=yes" /etc/default/rcS | wc -l

# Other stuff
sudo apt-file update
# Sometime rpi-update broke my Raspbian, so be carefull
#sudo rpi-update

sudo reboot