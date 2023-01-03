#! /bin/bash

# Install CoC
mkdir -p ~/.vim/pack/coc/start
cd ~/.vim/pack/coc/start
curl --fail -L https://github.com/neoclide/coc.nvim/archive/release.tar.gz|tar xzfv -

# Install Nim language and LSP ( export PATH=/home/devel/.nimble/bin:$PATH )
curl https://nim-lang.org/choosenim/init.sh -sSf | sh
nimble install nimlsp

# Install Zig and LSP
mkdir -p ~/code
cd code
git clone https://github.com/marler8997/zigbuild
cd zigbuild
sudo ./zig-update
