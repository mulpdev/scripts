#! /bin/bash

rm -rf ~/Documents ~/Music ~/Pictures ~/Public ~/Templates ~/Videos

mkdir -p ~/.config/nvim/
cp init.vim ~/.config/nvim/init.vim

cp .gitconfig ~/
cp .vimrc ~/
cp .tmux.conf ~/

# vim-common is for xxd
sudo apt install openssh-server neovim curl git vim-common tmux python3 build-essential nasm clang cmake
sudo systemctl enable ssh

## neovim using vim8 plugins
# Install CoC
mkdir -p ~/.vim/pack/coc/start
cd ~/.vim/pack/coc/start
curl --fail -L https://github.com/neoclide/coc.nvim/archive/release.tar.gz|tar xzfv -

# Wombat256 color theme
mkdir -p ~/.vim/colors
cd ~/.vim/colors
curl --fail -L https://github.com/gryf/wombat256grf/raw/master/colors/wombat256grf.vim > wombat256grf.vim

# Vim Polyglot
mkdir -p ~/.vim/pack/plugins/start/
git clone --depth 1 https://github.com/sheerun/vim-polyglot ~/.vim/pack/plugins/start/vim-polyglot

# Zig syntax highlighting
mkdir -p ~/.vim/pack/plugins/start/
cd ~/.vim/pack/plugins/start/
git clone https://github.com/ziglang/zig.vim

# Nim syntax highlighting
mkdir -p ~/.vim/pack/plugins/start/
cd ~/.vim/pack/plugins/start/
git clone https://github.com/zah/nim.vim

# Vim Tmux navigator
mkdir -p ~/.vim/pack/plugins/start/
git clone https://github.com/christoomey/vim-tmux-navigator.git ~/.vim/pack/plugins/start/vim-tmux-navigator

## Other tools

# Pwndbg
mkdir -p ~/code
cd code
git clone https://github.com/pwndbg/pwndbg
cd pwndbg
./setup.sh
echo "source ~/code/pwndbg/gdbinit" >> ~/.gdbinit

# Install Nim language and LSP ( export PATH=/home/devel/.nimble/bin:$PATH )
curl https://nim-lang.org/choosenim/init.sh -sSf | sh
nimble install nimlsp

# Install Zig and LSP
mkdir -p ~/code
cd code
git clone https://github.com/marler8997/zigbuild
cd zigbuild
sudo ./zig-update
