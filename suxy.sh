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

R='\033[0;31m'
G='\033[0;32m'
B='\033[0;34m'
N='\033[0m'

conf=${USER}.config

function get_config() {
    local configPath=$1
    local configName=$2
    sed -n 's/^[[:space:]]*'$configName'[[:space:]]*=[[:space:]]*\(.*[^[:space:]]\)\([[:space:]]*\)$/\1/p' $configPath
}

function set_config() {
    local configPath=$1
    local configName=$2
    local confgValue=$3
    sed -i 's/^[[:space:]]*'$configName'[[:space:]]*=.*/'$configName'='$confgValue'/g' $configPath
}

function getStr(){
    case $1 in
    (Y|y|true)
        echo '['${G}'y'${N}'/n]';;
    (N|n|false)
        echo '[y/'${G}'n'${N}']';;
    (*)
        echo '['${G}$1${N}']';;
    esac
}

function TF(){
    case $1 in
    (Y|y|true)  echo true;;
    (N|n|false) echo false;;
    (*)         echo $1;;
    esac
}

if [ ! -d $conf ]; then
    echo -e "${B}${HOME}/.${USER}.config${N} not found."
    echo -e "A default one will be downloaded and modified by yourself."
    wget https://raw.githubusercontent.com/SuXY15/SuXYrc/master/user.config -q -O ${HOME}/.${USER}.config
fi

_bGit=$(get_config $conf bGit)
_gName=$(get_config $conf gName)
_gEmail=$(get_config $conf gEmail)
_bSocks=$(get_config $conf bSocks)
_sPort=$(get_config $conf sPort)
_bZsh=$(get_config $conf bZsh)
_bTuna=$(get_config $conf bTuna)

read -p 'Would you want to change config?'$(getStr y) change
change=${change:-y}
if [ $change -eq y]; then
    read -p -e 'Would you want to set github user name and email globally?'$(getStr $_bGit) bGit
    bGit=${bGit:-_bGit}
    set_config $conf bGit $bGit
    if[ $(TF $bGit) ]; then
        read -p 'Enter your github name:'$(getStr $_gName) gName
        read -p 'Enter your github email:'$(getStr $_gEmail) gEmail
        gName=${gName:-${_gName}}
        gEmail=${gEmail:-${_gEmail}}
        set_config $conf gName $gName
        set_config $conf gEmail $gEmail
    fi
    read -p 'Would you want to use socks5 proxy for github globally?'$(getStr $_bSocks) bSocks
    bSocks=${bSocks:-_bSocks}
    set_config $conf bSocks $bSocks
    if[ $(TF $bSocks) ]; then
        read -p 'Enter your sock5 proxy port:'$(getStr $_sPort) sPort
        sPort=${sPort:-${_sPort}}
        set_config $conf sPort $sPort
    fi
    read -p 'Would you want to use oh-my-zsh?'$(getStr $_bZsh) bZsh
    bZsh=${bZsh:-_bZsh}
    set_config $conf bZsh $bZsh
    read -p 'Would you want to use oh-my-tuna?'$(getStr $_bTuna) bTuna
    bTuna=${bTuna:-_bTuna}
    set_config $conf bTuna $bTuna
fi 

# = = = = = = = = = = = = = = = =
# for git
if[ $(TF $bGit) ]; then
    echo -e "${G}Settings for git name and email config${N}"
    git config --global user.name ${gName}
    git config --global user.email ${gEmail}
    git config --global credential.helper store
fi
if[ $(TF $bSocks) ]; then
    git config --global http.https://github.com.proxy socks5://127.0.0.1:${sPort}
    git config --global https.https://github.com.proxy socks5://127.0.0.1:${sPort}
fi

# = = = = = = = = = = = = = = = = 
# for zsh
if[ $(TF $bZsh) ]; then
    echo -e "${G}Settings for oh-my-zsh and plugins${N}"
    sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -q -O -)"
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
    wget https://raw.githubusercontent.com/SuXY15/SuXYrc/master/suxyrc -q -O ${HOME}/.suxyrc
    if $SHELL -neq '/bin/zsh'
        chsh -s /bin/zsh
        echo -e "${B}You need to restart your terminal or machine to enable zsh auto-start."
    fi
fi

# = = = = = = = = = = = = = = = = 
# use tuna mirrors
if [ $(TF $bTuna) ]; then
    echo -e "${G}Settings for oh-my-tuna to use tuna mirrors in global environment${N}"
    python -c "$(wget https://tuna.moe/oh-my-tuna/oh-my-tuna.py -q -O -)" --global
fi

