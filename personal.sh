#! /bin/bash

rm -rf ~/Documents ~/Music ~/Pictures ~/Public ~/Templates ~/Videos

mkdir -p ~/.config/nvim/
cp init.vim ~/.config/nvim/init.vim

cp .gitconfig ~/
cp .vimrc ~/
cp .tmux.conf ~/

# vim-common is for xxd
sudo apt install openssh-server neovim curl git vim-common tmux python3 build-essential nasm clang cmake wget
sudo systemctl enable ssh

# Install wombat256 colorscheme
mkdir -p ~/.vim/colors
cd ~/.vim/colors
curl --fail -L https://github.com/gryf/wombat256grf/raw/master/colors/wombat256grf.vim > wombat256grf.vim

# Vim Polyglot
mkdir -p ~/.vim/pack/plugins/start/
cd ~/.vim/pack/plugins/start/
git clone --depth 1 https://github.com/sheerun/vim-polyglot ~/.vim/pack/plugins/start/vim-polyglot

# Vim Tmux navigator
mkdir -p ~/.vim/pack/plugins/start/
cd ~/.vim/pack/plugins/start/
git clone https://github.com/christoomey/vim-tmux-navigator.git ~/.vim/pack/plugins/start/vim-tmux-navigator

# Zig syntax highlighting
mkdir -p ~/.vim/pack/plugins/start/
cd ~/.vim/pack/plugins/start/
git clone https://github.com/ziglang/zig.vim

# Nim syntax Highlighting
mkdir -p ~/.vim/pack/plugins/start/
cd ~/.vim/pack/plugins/start/
git clone https://github.com/zah/nim.vim


## Other tools

# Pwndbg
mkdir -p ~/code
cd ~/code
git clone https://github.com/pwndbg/pwndbg
cd pwndbg
./setup.sh
echo "source ~/code/pwndbg/gdbinit" >> ~/.gdbinit

cd ~
echo "Done"
