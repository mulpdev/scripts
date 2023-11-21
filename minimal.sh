#! /bin/sh

set -e # stop on first error

DEPS="./deps"

while getopts 'cdiv' c
do
	case $c in
		c) CONFIGURE=True ;;
		d) DOWNLOAD=True ;;
		i) INSTALL=True ;;
		v) set -x # print commands to terminal ;;
	esac
done

# install and enable openssh server
# install curl, wget, nvim, git, xxd, tmux, python3, C/C++/gas compiler, nasm, clang, cmake, rsync

debian_derivative()
{
	# vim-common is for xxd
	sudo apt install openssh-server curl wget neovim git vim-common tmux python3 build-essential nasm clang cmake rsync
	sudo systemctl enable ssh
}

rhel_derivative()
{
	return
}

#######
# MAIN
#######

# Remove default directories
rm -rf ~/Documents ~/Music ~/Pictures ~/Public ~/Templates ~/Videos

# Install programs with system package manager
if [ -n "$INSTALL" ]; then
	# Determine OS
	. /etc/os-release
	case $ID in
		debian) echo "Detected Debian"
			debian_derivative
			;;

		ubuntu) echo "Detected Ubuntu"
			debian_derivative
			;;

		arch) 	echo "Detected Arch"
			return
			;;

		centos) echo "Detected CentOS"
			return
			;;

		rhel) 	echo "Detected Red Hat"
			return
			;;

		fedora) echo "Detected Fedora"
			return
			;;

		*) echo "Detected ??? Linux distro"
			return
			;;
	esac
fi

# Plugins
#
# Vim colorscheme: wombat256
# Vim Plugins: Vim Polyglot, Vim Tmux navigator, Zig syntax highlighting, Nim syntax Highlighting

# Download to $DEPS
if [ -n "$DOWNLOAD" ]; then
	# Download deps
	mkdir -p $DEPS

	curl --fail -L https://github.com/gryf/wombat256grf/raw/master/colors/wombat256grf.vim > $DEPS/wombat256grf.vim

	git clone --depth 1 https://github.com/sheerun/vim-polyglot $DEPS/vim-polyglot
	git clone https://github.com/christoomey/vim-tmux-navigator.git $DEPS/vim-tmux-navigator
	git clone https://github.com/ziglang/zig.vim $DEPS/zig
	git clone https://github.com/zah/nim.vim $DEPS/nim
fi

# Install from $DEPS
if [ -n "$CONFIGURE" ]; then
	VIM_COLORS="~/.vim/colors/"
	VIM_PLUGINS_START="~/.vim/pack/plugins/start/"
	
	mkdir -p $VIM_COLORS
	mkdir -p $VIM_PLUGINS_START
	
	cp -r $DEPS/wombat256grf.vim $VIM_COLORS
	
	cp -r $DEPS/vim-polyglot $VIM_PLUGINS_START
	cp -r $DEPS/vim-tmux-navigator $VIM_PLUGINS_START
	cp -r $DEPS/zig $VIM_PLUGINS_START
	cp -r $DEPS/nim $VIM_PLUGINS_START

	# Place config files
	mkdir -p ~/.config/nvim/
	cp init.vim ~/.config/nvim/init.vim
	cp .vimrc ~/
	cp .tmux.conf ~/
fi
