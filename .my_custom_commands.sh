#!/bin/bash

bold=$(tput bold)
normal=$(tput sgr0)
red='\033[0;31m'
indent='    '

help="
${bold}ccall help
\n${normal}run ccall help with --help
\n
\n${bold}how to use:\n
    ${indent}${normal}ccall targetdirectory --options
\n${bold}options:\n
    ${indent}${normal}--help: gives help

"
invalid_option="
${bold}Invalid target directory. Type --help for more information
"

function ccall() {
    if [[  $1 == '' ]]; then 
        echo -e $help  
        return        
    elif [[ $1 == '--help' ]]; then
        echo - e $help
        return
    fi

    if [[ ! -d $1 ]]; then
        echo -e $invalid_option
        return

    fi

    echo 'cloning backup...'

    origin_dir=$1
    temp_dir='tmp'

    if [[ ! -d "./tmp" ]]
    then    
        cp -r $origin_dir tmp
    else
        cp -r $origin_dir cursor_icons_tmp
        temp_dir='cursor_icons_tmp'
    fi

    cd $temp_dir

    for file in *; do 
        if [ "$file" = "default" ]; then
            continue 
        fi
        if [ -f "$file" ]; then 
            rm $file
            ln -s default $file  
            echo $file '--> Done'  
        fi 
        done

    cd ..

    rm -rf $origin_dir
    cp -r $temp_dir $origin_dir 
    rm -rf $temp_dir

    echo "${bold}Finished with exit code 0"


}

function gp(){
    msg='idk'
    if [[ ! -d "./.git" ]]; then 
        echo 'Not a dir'
        return
    fi

    if [[ $1 ]]; then 
        msg=$1
        echo "commiting with comment $1"
    fi


    echo $msg

    git add .
    git commit -m "$msg"
    git push
    git status

}

function runtest() {
    # if [[  $1 == '' ]]; then 
    #     echo nice 
    # elif [[ $1 == '--help' ]]; then
    #     echo sweet

    # fi

    # if [[ -d $1 ]]; then
    #     echo nice

    # fi
    # if [[ ! -d "./test/.git" ]]; then echo e 
    # fi

    if [[ ! $1 ]]; then ls && echo e
    fi

}