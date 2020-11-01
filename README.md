#### Usage

+ This script is used to set personal environment, including zsh, git, vim and linux sources.

```shell
sh -c "$(wget https://raw.githubusercontent.com/SuXY15/SuXYrc/master/suxy.sh -q -O -)"
```

### Personal Scripts

+ install zsh first

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

+ add source in .zshrc

  ```shell
  source "$HOME/.suxyrc"
  source $ZSH/oh-my-zsh.sh
  ```

+ generate ssh-key if nessary

  ```shell
  ssh-keygen -t rsa -C "suxy15tsinghua@gmail.com"
  ```

+ set github

  ```shell
  git config --global user.name SuXY15
  git config --global user.email suxy15tsinghua@gmail.com

  git config --global credential.helper store
  ```
+ set github socks port

  ```shell
  git config --global http.https://github.com.proxy socks5://127.0.0.1:1086
  git config --global https.https://github.com.proxy socks5://127.0.0.1:1086
  ```
+ tuna

  ```shell
  python -c "$(wget https://tuna.moe/oh-my-tuna/oh-my-tuna.py -q -O -)" --global
  ```

+ vim
  ```shell
  wget "https://raw.githubusercontent.com/SuXY15/SuXYrc/vimrc" -O ~/.vimrc
  ```

