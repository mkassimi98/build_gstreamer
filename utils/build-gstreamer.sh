#!/bin/bash

###
#       @file  build-gstreamer.sh
#     @author  Mouhsine Kassimi Farhaoui (MKF), mouhsine98@gmail.com
#   @internal
#     Created  22/06/2022
# Interpreter  bash 
#     Company  FADA-CATEC
#   Copyright  https://github.com/mkassimi98
###

# Set your target branch
BRANCH="1.18.0"
PROC=$(nproc)

exec > >(tee ../data/build-gstreamer.log)
exec 2>&1

[ ! -d gstreamer-$BRANCH ] && mkdir gstreamer-$BRANCH 
cd  gstreamer-$BRANCH || exit

if [ "$1" == "-d" ]; then
    [ ! -d gstreamer ] && git clone git://anongit.freedesktop.org/git/gstreamer/gstreamer
    [ ! -d gst-plugins-base ] && git clone git://anongit.freedesktop.org/git/gstreamer/gst-plugins-base
    [ ! -d gst-plugins-good ] && git clone git://anongit.freedesktop.org/git/gstreamer/gst-plugins-good
    [ ! -d gst-plugins-bad ] && git clone git://anongit.freedesktop.org/git/gstreamer/gst-plugins-bad
    [ ! -d gst-libav ] && git clone git://anongit.freedesktop.org/git/gstreamer/gst-libav
    [ ! -d gst-plugins-ugly ] && git clone git://anongit.freedesktop.org/git/gstreamer/gst-plugins-ugly
    [ ! -d gstreamer-vaapi ] && git clone https://github.com/GStreamer/gstreamer-vaapi.git
    [ ! -d srt ] && git clone https://github.com/Haivision/srt.git
    echo -e "$(tput setaf 2)FINISHED Download"
    exit
fi

#export LD_LIBRARY_PATH=/usr/local
prefix=/usr
# Change this to your local prefix
libdir=/usr/lib/x86_64-linux-gnu/

if [ "$1" == "-u" ]; then
    echo -e "$(tput setaf 1)$(tput setab 7)UNINSTALLING"

    cd gstreamer || exit
    sudo ninja -C build uninstall
    cd ..

    cd gst-plugins-base || exit
    sudo ninja -C build uninstall
    cd ..

    cd gst-libav || exit
    sudo ninja -C build uninstall
    cd ..

    cd gst-plugins-good || exit
    sudo ninja -C build uninstall
    cd ..

    cd gst-plugins-bad || exit
    sudo ninja -C build uninstall
    cd ..

    cd gst-plugins-ugly || exit
    sudo ninja -C build uninstall
    cd ..

    cd srt || exit
    sudo make uninstall
    cd ..

    echo -e "$(tput setaf 3)FINISHED UNINSTALL"
    exit
fi


##Dependencies##
if [ "$1" == "-p" ]; then
    echo -e "$(tput setaf 3) Installing Dependencies"
    sudo apt-get install -y cmake git autoconf autopoint
    sudo apt-get install -y gtk-doc-tools glib-2.0
    sudo apt-get install -y bison flex libglib2.0-dev
    sudo apt-get install -y libunwind-dev libdw-dev libgtk-3-dev
    sudo apt-get install -y libx11-dev xorg-dev libglu1-mesa-devfreeglut3-dev libglew1.5 libglew1.5-dev libglu1-mesa libglu1-mesa-dev libgl1-mesa-glx libgl1-mesa-dev


    # theora
    sudo apt-get install -y libtheora-bin libtheora-dev libtheora-doc

    # vorbis
    sudo apt-get install -y libvorbis-dev

    # cdparanoia
    sudo apt-get install -y libcdparanoia-dev

    sudo apt-get install -y alsa-base alsa-tools
    sudo apt-get install -y libasound2-dev
    sudo apt-get install -y libopus-dev libvisual-0.4-dev libpango1.0-dev


    sudo apt-get install -y libwavpack-dev libspeex-dev qt libjack-sdk libjpeg-dev libdv-dev libsoup2.4-dev qtdeclarative5-dev
    sudo apt-get install -y libcairo-dev

    sudo apt-get install -y yasm nasm libbz2-dev liblzma-dev


    sudo apt-get install -y x265 x264
    sudo apt-get install -y liborc-0.4-0 liborc-0.4-dev

    sudo apt-get install -y libx264-dev

    sudo apt-get install -y libva-dev tclsh

    pip3 install --user meson
    sudo apt-get install ninja-build

    echo -e "$(tput setaf 3)Restart the profile to load meson app executing the following command: $(tput setaf 2)$(tput setab 7)source ~/.profile" # Same as . ~/.profile

    echo -e "$(tput setaf 2)FINISHED Dependencies Install"
    exit
fi

################

function meson_build_install(){
	echo -e "$(tput setaf 3)You are in $pwd"
	meson build --prefix $prefix --libdir $libdir
	echo -e "$(tput setaf 2)$(tput setaf 7)Finish Meson configrue"
	ninja -C build || echo -e "Failed $(tput setaf 1)$(tput setab 7)ninja build" exit
	echo -e "Finish Ninja Build. Installing..."
	sudo ninja -C build install || echo -e "Failed $(tput setaf 1)$(tput setab 7)ninja install" exit
}

cd gstreamer || exit
git checkout $BRANCH
rm -rf build
meson_build_install
cd ..

cd gst-plugins-base || exit
git checkout $BRANCH
rm -rf build
meson_build_install
cd ..

cd gst-libav || exit
git checkout $BRANCH
rm -rf build
meson_build_install
cd ..

cd gst-plugins-good || exit
git checkout $BRANCH
rm -rf build
meson_build_install
cd ..

cd srt || exit
./configure --prefix $prefix
make -j$PROC
sudo make install
cd ..

cd gst-plugins-bad || exit  
git checkout $BRANCH
rm -rf build
meson_build_install
cd ..

cd gst-plugins-ugly || exit
git checkout $BRANCH
rm -rf build
meson_build_install
cd ..


cd gstreamer-vaapi || exit
git checkout $BRANCH
rm -rf build
meson_build_install
cd ..

#sudo ldconfig
