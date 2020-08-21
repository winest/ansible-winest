#!/bin/bash

DATE=`date +%Y%m%d`

git clone --recurse-submodules -j`nproc` "https://github.com/Valloric/YouCompleteMe.git"
mv "YouCompleteMe" "YouCompleteMe-${DATE}"
tar -czvf "YouCompleteMe-${DATE}.tar.gz" "YouCompleteMe-${DATE}"
