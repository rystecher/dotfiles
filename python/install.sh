if test ! $(which pyenv)
then
	brew install pyenv
	brew install pyenv-virtualenv

	pyenv install 3.9.2
	pyenv virtualenv 3.9.2 py3nvim
	pyenvactivate py3nvim
	pip install pynvim
fi

