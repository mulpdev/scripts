#! /bin/sh

set -x
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

debian_derivative()
{
	# vim-common is for xxd
	sudo apt install openssh-server curl wget neovim git vim-common tmux rsync
	sudo systemctl enable ssh
}

rhel_derivative()
{
	return
}

#######
# MAIN
#######

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
fi

if [ -n "$CONFIGURE" ]; then
	# Remove default directories
	rm -rf $HOME/Documents $HOME/Music $HOME/Pictures $HOME/Public $HOME/Templates $HOME/Videos

	VIM_COLORS="$HOME/.vim/colors/"
	VIM_PLUGINS_START="$HOME/.vim/pack/plugins/start/"
	
	mkdir -p $VIM_COLORS
	mkdir -p $VIM_PLUGINS_START
	
	cp -r $DEPS/wombat256grf.vim $VIM_COLORS
	cp -r $DEPS/vim-polyglot $VIM_PLUGINS_START
	cp -r $DEPS/vim-tmux-navigator $VIM_PLUGINS_START

	# Place config files
	mkdir -p $HOME/.config/nvim/
	cp init.vim $HOME/.config/nvim/init.vim
	cp .vimrc $HOME/
	cp .tmux.conf $HOME/

	# Update tmux.conf with everything in triple backtick markdown
	README=$DEPS/vim-tmux-navigator/README.md
	LINE=$(grep -n -m1 '``` tmux' $README)	# find first markdown code block opening with ``` tmux
	LINE=$(echo $LINE | cut -d':' -f1)			# isolate line number
	LINE=$((LINE+1))												# Next line to avoid occurance of  ``` tmux
	# can't exapnd variables in single quotes, thus the goofy concatenation but putting ' before and after variable
	CONFIG=$(sed -n ''$LINE',/```/p' $README | tr -d "\`") # print everything from LINE+1 until first occurance of ```
	printf '%s\n' "$CONFIG" >> $HOME/.tmux.conf
fi
