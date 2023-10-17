# linux-config

A repo for dotfiles and other linux config

### Setup

- Install [hh](https://github.com/dvorka/hstr)

- Install [antidote](https://github.com/mattmc3/antidote) zsh plugin manager and create bundle

```shell
# use /usr/bin for solus
# todo update to antidote for solus
# curl -sfL git.io/antibody | sudo sh -s - -b /usr/local/bin

antidote bundle < ./zsh_plugins.txt > ~/.zsh_plugins.zsh
```

- Create vim storage dirs

```shell
mkdir -p ~/.vimbackup ~/.vimswp ~/.vimundo
```

- Symlink function and alias dirs

```shell
# *nix
ln -sri zsh_aliases.d $HOME/.zsh_aliases.d
ln -sri zsh_functions.d $HOME/.zsh_functions.d

# macOS (use absolute paths)
ln -si "$(pwd)"/zsh_aliases.d $HOME/.zsh_aliases.d
ln -si "$(pwd)"/zsh_functions.d $HOME/.zsh_functions.d
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
# .bashrc
source ~/development/linux-config/bashrc

# .zshrc
source ~/development/linux-config/zshrc
```

#### `.gitconfig`

```
[include]
    path = development/linux-config/gitconfig
```

