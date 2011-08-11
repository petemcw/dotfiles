# Installation #

	git clone git://github.com/petemcw/Dotfiles.git ~/.dotfiles
	cd ~/.dotfiles
	git submodule init 
	git submodule update 
	rake install

## Ruby Version Manager ##

	bash < <(curl -s https://rvm.beginrescueend.com/install/rvm)
	rvm install ruby-1.9.2-head

# Environment #

This repository is mainly setup for `zsh`.  If you would like to switch to `zsh`, you can do so with the following command.

	chsh -s /bin/zsh
