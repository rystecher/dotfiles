# Install nvim
if test ! $(which nvim)
then
	echo "Installing nvim..."
	brew install nvim
	echo "nvim installed"
else
	echo "nvim already installed"
fi

# Symlink config
if ! [[ -e $HOME/.config/nvim/init.vim ]]
then
	echo "Symlinking nvim/init.vim ..."
	mkdir -p $HOME/.config/nvim
	ln -s $HOME/.dotfiles/config/nvim/init.vim $HOME/.config/nvim/init.vim
	echo "Symlinked nvim/init.vim"
else
	echo "nvim already configured"
fi

