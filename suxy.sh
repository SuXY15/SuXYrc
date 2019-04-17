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

# = = = = = = = = = = = = = = = =
# for git
echo -e "${G}Settings for git config${N}"
git config --global user.name SuXY15
git config --global user.email suxy15tsinghua@gmail.com
git config --global credential.helper store

# = = = = = = = = = = = = = = = = 
# for zsh
echo -e "${G}Settings for oh-my-zsh and plugins${N}"
sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -q -O -)"
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
wget https://raw.githubusercontent.com/SuXY15/SuXYrc/master/suxyrc -q -O ${HOME}/.suxyrc
chsh -s /bin/zsh
echo -e "${B}You need to restart your terminal or machine to enable zsh auto-start."

# = = = = = = = = = = = = = = = = 
# use tuna mirrors
echo -e "${G}Settings for oh-my-tuna to use tuna mirrors in global environment${N}"
python -c "$(wget https://tuna.moe/oh-my-tuna/oh-my-tuna.py -q -O -)" --global

