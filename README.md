# linux-config

A repo for dotfiles and other linux config

### Setup

- Install [hh](https://github.com/dvorka/hstr)

- Install [antibody](https://github.com/getantibody/antibody) zsh plugin manager and create bundle

```shell
# use /usr/bin for solus
curl -sfL git.io/antibody | sudo sh -s - -b /usr/local/bin

antibody bundle < ./zsh_plugins.txt > ~/.zsh_plugins.sh
```

- Create vim storage dirs

```shell
mkdir -p ~/.vimbackup ~/.vimswp ~/.vimundo
```

- Symlink function and alias dirs

```shell
ln -sri zsh_aliases.d $HOME/.zsh_aliases.d
ln -sri zsh_functions.d $HOME/.zsh_functions.d
```

### Option 1: Symlink setup

```shell
ln -sri bashrc $HOME/.bashrc
ln -sri gitconfig $HOME/.gitconfig
ln -sri vimrc $HOME/.vimrc
ln -sri zshrc $HOME/.zshrc
```

### Option 2: Non-symlink setup

#### `.bashrc`/`.zshrc`

Source the file:

```shell
source ~/development/linux-config/bashrc
```

#### `.gitconfig`

```
[include]
    path = development/linux-config/gitconfig
```

