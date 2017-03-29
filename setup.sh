#!/bin/bash

if ! which zsh &> /dev/null; then
	echo "zsh must be installed"
	exit 1
fi

if which wget &> /dev/null; then
	DOWNLOAD="wget"
	DOWNLOAD_TO_STDOUT="wget -O -"
elif which curl &> /dev/null; then
	DOWNLOAD="curl -O"
	DOWNLOAD_TO_STDOUT="curl"
else
	echo "Either wget or curl must be installed"
	exit 2
fi

ZSH=$HOME/.oh-my-zsh

mkdir setuptmp
cd setuptmp
sh -c "$($DOWNLOAD_TO_STDOUT https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

$DOWNLOAD https://raw.githubusercontent.com/mcmathews/dotfiles/master/.git-prompt.sh
$DOWNLOAD https://raw.githubusercontent.com/mcmathews/dotfiles/master/hotchkis.zsh-theme
$DOWNLOAD https://raw.githubusercontent.com/mcmathews/dotfiles/master/.zshrc
$DOWNLOAD https://raw.githubusercontent.com/mcmathews/dotfiles/master/.gitconfig
$DOWNLOAD https://raw.githubusercontent.com/mcmathews/dotfiles/master/.vimrc

mkdir $ZSH/custom/themes
cp "hotchkis.zsh-theme" "$ZSH/custom/themes/"
cp "git-prompt.sh" "$ZSH/custom"
cp ".zshrc" "$HOME"

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
