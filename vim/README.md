# VIM

## Setup

**Warning:** Use at your own risk!

### Dependencies

My environment depends on:

* [vim/vim] >= 8.0
* [vundlevim/vundle.vim] >= 0.10.2

### Installation

Package manager:

``` bash
pacman -S vim git
```

Setup vim:

``` bash
git clone git@github.com:rowanruseler/dotfiles.git /tmp/dotfiles \
  && mkdir -p ~/.vim/bundle/ \
  && mv /tmp/dotfiles/vim/.vim/* ~/.vim/. \
  && mv /tmp/dotfiles/vim/.vimrc ~/.vimrc \
  && git clone git@github.com:VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim \
  && rm -I /tmp/dotfiles
```

Install all vim plugins, execute command in `~/.vim/plugins.vim`:

``` bash
:PluginInstall
```

## Usage

### Text editor

You can exit vim by colon (:) character 'q'.

Start the text editor:

``` bash
vim
```

Open a file:

``` bash
vim ./filename
```

Open specific line within file:

``` bash
vim ./filename +42
```

[vim/vim]: https://github.com/vim/vim
[vundlevim/vundle.vim]: https://github.com/VundleVim/Vundle.vim
