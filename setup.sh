#!/bin/sh

$ZSH=$HOME/.oh-my-zsh

mkdir setuptmp
cd setuptmp
sh -c "$(wget https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"

wget https://raw.githubusercontent.com/mcmathews/dotfiles/master/.git-prompt.sh
wget https://raw.githubusercontent.com/mcmathews/dotfiles/master/hotchkis.zsh-theme
wget https://raw.githubusercontent.com/mcmathews/dotfiles/master/.zshrc
wget https://raw.githubusercontent.com/mcmathews/dotfiles/master/.gitconfig
wget https://raw.githubusercontent.com/mcmathews/dotfiles/master/.vimrc

mkdir $ZSH/custom/themes
cp hotchkis.zsh-theme $ZSH/custom/themes/
cp .git-prompt.sh $ZSH/
cp .zshrc $HOME

if [ -f $HOME/.vimrc ]; then
	echo ".vimrc already exists. Overwrite it? (y/n) "
	read i
	if [ "$i" = "y" ]; then
		cp .vimrc $HOME
	fi
else
	cp .vimrc $HOME
fi

if [ -f $HOME/.gitconfig ]; then
	echo ".gitconfig already exists. Overwrite it? (y/n) "
	read i
	if [ "$i" = "y" ]; then
		cp .gitconfig $HOME
	fi
else
	cp .gitconfig $HOME
fi

cd ..
rm -rf setuptmp
