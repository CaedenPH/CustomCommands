#!/bin/bash

bold=$(tput bold)
normal=$(tput sgr0)
red='\033[0;31m'
indent="        "
help="
${bold}ccall help
\n${normal}run ccall help with --help
\n
\n${bold}how to use:\n
$indent ${normal}ccall targetdirectory --options
\n\n${bold}options:\n
$indent ${normal}--help: shows help    
${normal}--target=default: changes default cursor target
${normal}--ignore
"
invalid_option="
${bold}Invalid target directory. Type --help for more information
"
OPTION=""
DEFAULT="default"
no_default="There is no default cursor in the directory. Create an image in the directory for the default or set --default=default. Type --help for more information"

ccall() {
    for i in "$@"
    do
    case $i in
        --default=*)
        DEFAULT="${i#*=}"
        ;;
        --help)
        echo -e $help
        return
        ;;

    esac
    done

    if [[ ! -d $1 ]]; then
        echo $invalid_option 
        return
    fi
    
    if [[ ! -f "./$1/$DEFAULT" ]]; then
    echo $no_default
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
        if [ "$file" = $DEFAULT ]; then
            continue 
        fi
        if [ -f "$file" ]; then 
            rm $file
            ln -s $DEFAULT $file  
            echo $file '--> Done'  
        fi 
        done

    cd ..

    rm -rf $origin_dir
    cp -r $temp_dir $origin_dir 
    rm -rf $temp_dir

    echo "${bold}Finished with exit code 0"


}


gp(){
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

runtest() {
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

    # if [[ ! $1 ]]; then ls && echo e
    # fi

    # case $1 in 

    #     e)
    #     echo 'x'
    #     ;;

    # esac
    # OPTION=""
    # DEFAULT=""
    # HELP=""

    # for i in "$@"
    # do
    # case $i in
    #     --option=*)
    #     OPTION="${i#*=}"
    #     ;;
    #     --default=*)
    #     DEFAULT="${i#*=}"
    #     ;;
    #     --help)
    #     HELP="yes"
    #     ;;
    #     *)
    #     HELP="yes"

    # esac
    # done
    # echo $OPTION, $DEFAULT, $HELP 

    # if [[ -f "./cursors/default" ]]; then echo 'e'
    # fi

    # for i in *; do

    #     if [[ ! -x $i ]]; then
    #     echo $i
    #     fi
    # done

    # if ls ; then
    # # Here, we test that the return code of `ls` was zero, if not we print some warning
    # printf "ls failed, that's a very rare things to happen!" >&2
    # exit 1
    # fi

    # opts=("$@")
    # echo $opts

    if [[ -z $1 ]]; then 
    echo e  
    fi
}

modall() {
    shopt -s dotglob
    for i in *; do  
        case $i in 
            *.sh)
                if [[ ! -x $i ]]; then
                chmod +x $i
                echo $i
            fi
            ;;
            *)
            ;;

        esac
    done
}

up() { 
    current="$(pwd)"
    cd ~/Github/CustomCommands/Scripts/
    for i in *; do 
	source $i
    done
    cd $current

}

runcode() { 
    cd ~/Github/CustomCommands
    num=0

    while [[ ! $func ]]; do
        letters="$(python randomletters.py)"
        if ! $letters; then 
            echo "Command worked! command was $letters on take $num"
            return  
        fi
        let "num+=1"
    echo eee
    done

}

spamcuscool() {
    for i in `seq 0 1000000`; do
        output="$(python randomoutput.py)"
        echo "Generating file --> $output"

    done
}