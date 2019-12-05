#### Usage
```shell
sh -c "$(wget https://raw.githubusercontent.com/SuXY15/SuXYrc/master/suxy.sh -q -O -)"
```

### Personal Scripts

+ install zsh first, by `apt-get install zsh` or `sudo pacman -S zsh` or `yum -y install zsh`

+ install oh-my-zsh

  ```shell
  sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -q -O -)"
  ```

+ install zsh plugins:

  + syntax-highlighting

    ```shell
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
    ```

  + autosuggestions

    ```shell
    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
    ```

+ download suxyrc

  ```shell
  wget https://raw.githubusercontent.com/SuXY15/SuXYrc/master/suxyrc -q -O ${HOME}/.suxyrc
  ```

+ add source to zshrc

  ```shell
  source "$HOME/.suxyrc"
  ```

+ generate ssh-key

  ```shell
  ssh-keygen -t rsa -C "suxy15tsinghua@gmail.com"
  ```

+ set github

  ```shell
  git config --global user.name SuXY15
  git config --global user.email suxy15tsinghua@gmail.com

  git config --global credential.helper store
  ```

+ tuna

  ```shell
  python -c "$(wget https://tuna.moe/oh-my-tuna/oh-my-tuna.py -q -O -)" --global
  ```

+ vim
  ```shell
  wget "https://raw.githubusercontent.com/SuXY15/SuXYrc/vimrc" -O ~/.vimrc
  ```

