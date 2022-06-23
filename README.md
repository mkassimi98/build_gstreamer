# README #

This repository is to build and install gstreamer with vaapi and srt using the version 1.18.

### What is this repository for? ###

* Build and install custom gstreamer from source.
* Version 0.1

### How do I get set up? ###

* Choose the version of gstreamer you want to install and your user profile

        > $ cd utils
        > $ nano build-gstreamer.sh 
            # Edit the script to your needs: 
                # BRANCH="1.18.0"
                # prefix=/xx/xx/xx
                # libdir=/xx/xx/xx
        > $ cd ..

* Install dependencies
        
        > $ cd utils
        > # ./build-gstreamer.sh -p
        > $ cd ..

* Clone the repositorys from github
        
        > $ cd utils
        > # ./build-gstreamer.sh -d
        > $ cd ..

* Build and install gstreamer
        
        > $ cd utils
        > # ./build-gstreamer.sh 
        > $ cd ..

### Uninstall from the system ###

* Uninstall gstreamer
        
        > $ cd utils
        > # ./build-gstreamer.sh -u
        > $ cd ..

### Debug ###

* The script will print the commands that are executed, and the script will exit with an error code if any of the commands fails.
* The script script will log the output of the commands into data/build-gstreamer.log

### Contribution guidelines ###

* **gstreamer-guide**: https://gstreamer.freedesktop.org/documentation/?gi-language=c
* **meson**: https://mesonbuild.com/
* **ninja**: https://ninja-build.org/
* **Jetson Gstreamer Guide**: https://developer.download.nvidia.com/embedded/L4T/r32_Release_v1.0/Docs/Accelerated_GStreamer_User_Guide.pdf
* **Vaapi examples**: https://01.org/linuxmedia/quickstart/gstreamer-vaapi-msdk-command-line-examples
* **Srt examples**: https://srtlab.github.io/srt-cookbook/apps/gstreamer-plugin / https://www.collabora.com/news-and-blog/blog/2018/02/16/srt-in-gstreamer/

### Who do I talk to? ###

* [Mouhsine Kassimi](mouhsine98@gmail.com)
