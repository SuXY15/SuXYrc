#!/bin/bash

# This is a personal environment setting script of Xingyu Su
# You can find me at http://suxy.info
#  ____       __  ____   __
# / ___| _   _\ \/ /\ \ / /
# \___ \| | | |\  /  \ V / 
#  ___) | |_| |/  \   | |  
# |____/ \__,_/_/\_\  |_|  
#
# Copyright 2019 Xingyu Su

R='\033[1;31m'
G='\033[1;32m'
B='\033[1;34m'
N='\033[0m'
conf=${HOME}/.${USER}.config

# = = = = = = = = = = = = = = = = 
# functions
function get_config() {
    local key=$1
    sed -n 's/^[[:space:]]*'$key'[[:space:]]*=[[:space:]]*\(.*[^[:space:]]\)\([[:space:]]*\)$/\1/p' $conf
}

function set_config() {
    local key=$1
    local value=$2
    sed -i -e 's/^[[:space:]]*'$key'[[:space:]]*=.*/'$key' = '$value'/g' $conf
}

function getStr(){
    case $1 in
    (Y|y|true)  echo '['${G}'y'${N}'/n]';;
    (N|n|false) echo '[y/'${G}'n'${N}']';;
    (*)         echo '['${G}$1${N}']';;
    esac
}

function TF(){
    case $1 in
    (Y|y|true)  echo true;;
    (N|n|false) echo false;;
    (*)         echo $1;;
    esac
}

# = = = = = = = = = = = = = = = = 
# check configure file existence
if [ ! -f $conf ]; then
    echo -e "${R}$conf${N} not found."
    echo -e "A default one will be downloaded and modified by yourself."
    wget https://raw.githubusercontent.com/SuXY15/SuXYrc/master/user.config -q -O $conf
else
    echo -e "${B}$conf${N} detected."
fi

# = = = = = = = = = = = = = = = = 
# read configure file
_bGit=$(get_config bGit)
_gName=$(get_config gName)
_gEmail=$(get_config gEmail)
_bSocks=$(get_config bSocks)
_sPort=$(get_config sPort)
_bZsh=$(get_config bZsh)
_bTuna=$(get_config bTuna)

# = = = = = = = = = = = = = = = = 
# change configure files
echo -e 'Would you want to change config?'$(getStr y)'\c'
read change; change=${change:-y}
if [ $(TF $change) == 'true' ]; then
    echo -e 'Set github user name and email globally?'$(getStr $_bGit)'\c'
    read bGit; bGit=${bGit:-$_bGit}
    set_config 'bGit' $bGit
    if [ $(TF $bGit) == 'true' ]; then
        echo -e 'Enter your github name:'$(getStr $_gName)'\c'
        read gName; gName=${gName:-${_gName}}
        echo -e 'Enter your github email:'$(getStr $_gEmail)'\c'
        read gEmail; gEmail=${gEmail:-${_gEmail}}
        set_config gName $gName
        set_config gEmail $gEmail
    fi
    echo -e 'Use socks5 proxy for github globally?'$(getStr $_bSocks)'\c'
    read bSocks; bSocks=${bSocks:-${_bSocks}}
    set_config bSocks $bSocks
    if [ $(TF $bSocks) == 'true' ]; then
        echo -e 'Enter your sock5 proxy port:'$(getStr $_sPort)'\c'
        read sPort; sPort=${sPort:-${_sPort}}
        set_config sPort $sPort
    fi
    echo -e 'Would you want to use oh-my-zsh?'$(getStr $_bZsh)'\c'
    read bZsh; bZsh=${bZsh:-${_bZsh}}
    set_config bZsh $bZsh
    echo -e 'Would you want to use oh-my-tuna?'$(getStr $_bTuna)'\c'
    read bTuna; bTuna=${bTuna:-${_bTuna}}
    set_config bTuna $bTuna
else
    bGit=$_bGit
    gName=$_gName
    gEmail=$_gEmail
    bSocks=$_bSocks
    sPort=$_sPort
    bZsh=$_bZsh
    bTuna=$_bTuna
fi 

# = = = = = = = = = = = = = = = =
# for git
if [ $(TF $bGit) == 'true' ]; then
    echo -e "${G}Settings for git name and email config${N}"
    git config --global user.name ${gName}
    git config --global user.email ${gEmail}
    git config --global credential.helper store
fi
if [ $(TF $bSocks) == 'true' ]; then
    git config --global http.https://github.com.proxy socks5://127.0.0.1:${sPort}
    git config --global https.https://github.com.proxy socks5://127.0.0.1:${sPort}
fi
sGPG=AAAAAAAAAAAAA
if [ $(TF $bGPG) == 'True' ]; then
    git config --global user.signingkey $sGPG
fi

# = = = = = = = = = = = = = = = = 
# for zsh
if [ $(TF $bZsh) == 'true' ]; then
    echo -e "${G}Settings for oh-my-zsh and plugins${N}"
    sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -q -O -)"
    target=${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
    if [ ! -d $target ]; then
        git clone https://github.com/zsh-users/zsh-syntax-highlighting.git 
    fi
    target=${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
    if [ ! -d $target ]; then
        git clone https://github.com/zsh-users/zsh-autosuggestions
    fi
    wget https://raw.githubusercontent.com/SuXY15/SuXYrc/master/suxyrc -q -O ${HOME}/.suxyrc
    if [ $SHELL != '/bin/zsh' ]; then
        chsh -s /bin/zsh
        echo -e "${B}You need to restart your terminal or machine to enable zsh auto-start."
    fi
fi

# = = = = = = = = = = = = = = = = 
# use tuna mirrors
if [ $(TF $bTuna) == 'true' ]; then
    echo -e "${G}Settings for oh-my-tuna to use tuna mirrors in global environment${N}"
    python -c "$(wget https://tuna.moe/oh-my-tuna/oh-my-tuna.py -q -O -)" --global
fi

