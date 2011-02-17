# Installation #

	git clone git://github.com/petemcw/Dotfiles.git ~/.dotfiles
	cd ~/.dotfiles
	git submodule init oh-my-zsh
	git submodule update oh-my-zsh
	git submodule init rvm
	git submodule update rvm
	rake install

## Ruby Version Manager ##

	chmod +x ~/.rvm/src/rvm/install
	~/.rvm/src/rvm/install
	source ~/.rvm/scripts/rvm
	rvm install ruby-1.9.2-head

# Environment #

This repository is mainly setup for `zsh`.  If you would like to switch to `zsh`, you can do so with the following command.

	chsh -s /bin/zsh
