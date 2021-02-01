#!/bin/sh

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
    echo "${R}$conf${N} not found."
    echo "A default one will be downloaded and modified by yourself."
    wget https://raw.githubusercontent.com/SuXY15/SuXYrc/master/user.config -q -O $conf
else
    echo "${B}$conf${N} detected."
fi

# = = = = = = = = = = = = = = = =
# read configure file
_Git=$(get_config Git)
_GitName=$(get_config GitName)
_GitEmail=$(get_config GitEmail)
_GitSocks=$(get_config GitSocks)
_GitSocksPort=$(get_config GitSocksPort)
_GPG=$(get_config GPG)
_GPGKey=$(get_config GPGKey)
_Zsh=$(get_config Zsh)
_Tuna=$(get_config Tuna)

# = = = = = = = = = = = = = = = =
# change configure files
echo 'Would you want to change config?'$(getStr y)'\c'
read change; change=${change:-y}
if [ $(TF $change) == 'true' ]; then
    echo 'Set github user name and email globally?'$(getStr $_Git)'\c'
    read Git; Git=${Git:-$_Git}
    set_config 'Git' $Git
    if [ $(TF $Git) == 'true' ]; then
        echo 'Enter your github name:'$(getStr $_GitName)'\c'
        read GitName; GitName=${GitName:-${_GitName}}
        echo 'Enter your github email:'$(getStr $_GitEmail)'\c'
        read GitEmail; GitEmail=${GitEmail:-${_GitEmail}}
        set_config GitName $GitName
        set_config GitEmail $GitEmail
    fi

    echo 'Use socks5 proxy for github globally?'$(getStr $_GitSocks)'\c'
    read GitSocks; GitSocks=${GitSocks:-${_GitSocks}}
    set_config GitSocks $GitSocks
    if [ $(TF $GitSocks) == 'true' ]; then
        echo 'Enter your sock5 proxy port:'$(getStr $_GitSocksPort)'\c'
        read GitSocksPort; GitSocksPort=${GitSocksPort:-${_GitSocksPort}}
        set_config GitSocksPort $GitSocksPort
    fi

    echo 'Use GPG key for github globally?'$(getStr $_GPG)'\c'
    read GPG; GPG=${GPG:-${_GPG}}
    set_config GPG $GPG
    if [ $(TF $GPG) == 'true' ]; then
        echo 'Enter your GPG id:'$(getStr $_GPGKey)'\c'
        read GPGKey; GPGKey=${GPGKey:-${_GPGKey}}
        set_config GPGKey $GPGKey
    fi

    echo 'Would you want to use oh-my-zsh?'$(getStr $_Zsh)'\c'
    read Zsh; Zsh=${Zsh:-${_Zsh}}
    set_config Zsh $Zsh
    echo 'Would you want to use oh-my-tuna?'$(getStr $_Tuna)'\c'
    read Tuna; Tuna=${Tuna:-${_Tuna}}
    set_config Tuna $Tuna
else
    Git=$_Git
    GitName=$_GitName
    GitEmail=$_GitEmail
    GitSocks=$_GitSocks
    GitSocksPort=$_GitSocksPort
    GPG=$_GPG
    GPGKey=$_GPGKey
    Zsh=$_Zsh
    Tuna=$_Tuna
fi

# = = = = = = = = = = = = = = = =
# for git
if [ $(TF $Git) == 'true' ]; then
    echo "${G}Settings for git name and email config${N}"
    git config --global user.name ${GitName}
    git config --global user.email ${GitEmail}
    git config --global credential.helper store
fi
if [ $(TF $GitSocks) == 'true' ]; then
    git config --global http.https://github.com.proxy socks5://127.0.0.1:${GitSocksPort}
    git config --global https.https://github.com.proxy socks5://127.0.0.1:${GitSocksPort}
fi
if [ $(TF $GPG)=='true' ]; then
    git config --global user.signingkey ${GPGKey}
fi

# = = = = = = = = = = = = = = = = 
# for zsh
if [ $(TF $Zsh) == 'true' ]; then
    echo "${G}Settings for oh-my-zsh and plugins${N}"
    sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -q -O -)"
    target=${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
    if [ ! -d $target ]; then
        git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
    fi
    target=${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
    if [ ! -d $target ]; then
        git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
    fi
    wget https://raw.githubusercontent.com/SuXY15/SuXYrc/master/suxyrc -q -O ${HOME}/.suxyrc
    if [ $SHELL != '/bin/zsh' ]; then
        chsh -s /bin/zsh
        echo "${B}You need to restart your terminal or machine to enable zsh auto-start."
    fi
fi

# = = = = = = = = = = = = = = = =
# use tuna mirrors
if [ $(TF $Tuna) == 'true' ]; then
    echo "${G}Settings for oh-my-tuna to use tuna mirrors in global environment${N}"
    python -c "$(wget https://tuna.moe/oh-my-tuna/oh-my-tuna.py -q -O -)" --global
fi

# = = = = = = = = = = = = = = = =
# finish
echo "${G}Settings for SuXYrc is finished.${N}"
echo "Please make sure to have ${G}source $HOME/.suxyrc${N} in your zshrc"
echo "or you can use:\n"
echo "\techo \"source \$HOME/.suxyrc\" >> \$HOME/.zshrc \n"
