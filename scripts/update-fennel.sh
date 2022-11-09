#!/bin/bash


libdir=$1
release=$2

if [ "$#" = 0 ]; then
    echo -e "Usage: update-fennel.sh libdir [release]\n\n\
Example: ./update-fennel.sh \$(pwd)/../lib/ 1.2.0"
    exit 0;
fi

cd /tmp/
git clone https://github.com/bakpakin/Fennel.git
cd Fennel


if [ $release ]
then
    
    git checkout tags/$release
fi


make

cp fennel fennel.lua $libdir

rm -rf /tmp/Fennel/
