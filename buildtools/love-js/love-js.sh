#!/bin/bash

help="love-js.sh: \n
    A tool for assembling love.js projects without relying on npm / node. \n\
    For the full project please see https://github.com/Davidobot/love.js \n\
\n\
usage: \n\
    ./love-js.sh [love-file] [project-name] [opts]\n\
\n
opts:\n
  -v= (--version=) Version of the Game. Will be included in file name.\n
  -o= (--output-directory=) Target directory. Defaults to PWD\n
  -t= (--text-colour=) Text Colour. Defaults to \"240,234,214\"\n
  -c= (--canvas-colour=) Canvas Colour. Defaults to \"54,69,79\"\n
  -a= (--author=) Author (Shows up on loading page).\n
  -w= (--width=) Canvas Width (game width in conf). Defaults to 800\n
  -h= (--height=) Canvas Height (game height in conf). Defaults to 600\n
  -r  (--run) Set flag if you want to run a local copy on port 8000\n
  -d  (--debug) Set flag for debug info\n
  -h  (--help) Display this text\n
\n
eg: \n\

Pack up sample.love\n
\t./love-js.sh sample.love sample\n
\t> sample-web.zip\n
\n
Pack up sample.love version 0.1.0\n
\t./love-js.sh sample-0.1.0.love sample -v=0.1.0\n
\t> sample-0.1.0-web.zip\n
\n
Pack up sample.love and set the background colour to black\n
\t./love-js.sh sample-0.1.0.love sample -v=0.1.0 -c=\"0,0,0\"\n
\t> sample-0.1.0-web.zip\n
\n
Pack up sample.love and set the author to \"Sample Name\"\n
\t./love-js.sh sample-0.1.0.love sample -a=\"Sample Name\"\n
\t> sample-web.zip"

if [ "$#" -lt  "2" ]
  then
      echo "ERROR! love-js.sh expects at least two arguments."
      echo -e $help
      exit 1
fi

# use gdu on macOS, fixes 'invalid option -b' error
if [ "$(uname -s)" = "Darwin" ]; then
  DU_CMD=gdu
else
 DU_CMD=du
fi

love_file=$1
name=$2
## confirm that $release_dir/$name-$version.love exists
if [ ! -f $love_file ]; then
    echo "love file not found!"
    echo $love_file
    exit 1
fi

if [ -f /proc/sys/kernel/random/uuid ]; then
   uuid=$(cat /proc/sys/kernel/random/uuid)
else
    uuid="2fd99e56-5455-45dd-86dd-7af724874d65"
fi

author="";
run=false;
debug=false;
gethelp=false;
width=800
height=600
release="compat"
love_version="11.4"
canvas_colour="54,69,79"
text_colour="240,234,214"
initial_memory=0
module_size=$($DU_CMD -b $love_file | awk '{print $1}')
title=$(echo $name | sed -r 's/\<./\U&/g' | sed -r 's/-/\ /g')
version=""
dash_version=""
output_dir=$(pwd)
cachemodule="true"

for i in "$@"
do
case $i in
    -v=*|--version=*)
    version="${i#*=}"
    dash_version="-${i#*=}"
    ;;
    -o=*|--output-directory=*)
    output_dir="${i#*=}"
    ;;
    -w=*|--width=*)
    width="${i#*=}"
    ;;    
    -h=*|--height=*)
    height="${i#*=}"
    ;;
    -t=*|--text-colour=*)
    text_colour="${i#*=}"
    ;;
    -c=*|--canvas-colour=*)
    canvas_colour="${i#*=}"
    ;;
    -a=*|--author=*)
    author="${i#*=}"
    ;;        
    -r|--run)
    run=true
    ;;
    -d|--debug)
    debug=true
    ;;
    -h|--help)
    gethelp=true
    ;;
    -n|--no-cache)
    cachemodule="false"
    ;;    
    *)
            # unknown option
    ;;
esac
done

page_colour=$canvas_colour

file_name=$output_dir/$name$dash_version-web

debug (){
    if [ $debug = true ]
    then
        echo ""
        echo "Debug:         love-js.sh"
        echo "love file:     ${love_file}"
        echo "output file:   $file_name"
        echo "author:        $author"
        echo "version:       $version"
        echo "text colour:   $text_colour"
        echo "canvas colour: $canvas_colour"
        echo "canvas size:   ${height}, ${width}"
        echo "run:           ${run}"
        echo "use cache:     $cachemodule"
    fi
}

call_dir=$(pwd)
root="$(dirname "$0")"

build(){
    rm -fr $file_name
    mkdir -p $file_name && mkdir -p $file_name/theme

    cat $root/src/index.html | \
        sed "s/{{title}}/${title}/g" | \
        sed "s/{{version}}/${version}/g" | \
        sed "s/{{author}}/${author}/g" | \
        sed "s/{{width}}/${width}/g" | \
        sed "s/{{height}}/${height}/g" | \
        sed "s/{{initial-memory}}/${initial_memory}/g" | \
        sed "s/{{canvas-colour}}/${canvas_colour}/g" | \
        sed "s/{{text-colour}}/${text_colour}/g" > \
            $file_name/index.html
    
    cat $root/src/love.css | \
        sed "s/{{page-colour}}/${page_colour}/g" > \
            $file_name/theme/love.css
    
    cat $root/src/game.js | \
        sed "s/{{{cachemodule}}}/${cachemodule}/g" | \
        sed "s/{{{metadata}}}/{\"package_uuid\":\"${uuid}\",\"remote_package_size\":$module_size,\"files\":[{\"filename\":\"\/game.love\",\"crunched\":0,\"start\":0,\"end\":$module_size,\"audio\":false}]}/" > \
            $file_name/game.js
    cp $root/src/serve.py $file_name
    cp $root/src/consolewrapper.js $file_name
    cp $love_file $file_name/game.love
    cp $root/src/love-$love_version/$release/love.js $file_name
    cp $root/src/love-$love_version/$release/love.wasm $file_name
    if [ $release == "release" ]; then
        cp $root/src/release/love.worker.js $file_name
    fi
}

clean(){
    rm -rf $file_name
}

release (){
    rm -fr $file_name
    build
    debug
    zip -r -q tmp $file_name
    rm -f $file_name.zip
    mv tmp.zip $file_name.zip
    clean
}

run (){
    debug
    build
    cd $file_name
    python3 serve.py
}

if [ $gethelp = true ]
then
    echo -e $help
elif [ $run = false ]
then
    release
else
    run
fi
