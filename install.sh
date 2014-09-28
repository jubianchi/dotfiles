#!/bin/bash

DOTFILES_TARGET_DIR=${DOTFILES_TARGET_DIR-$HOME/.dotfiles}
DOTFILES_TARGET_DIR=${1-$DOTFILES_TARGET_DIR}

if [ ! -d "$DOTFILES_TARGET_DIR" ]
then
	git clone https://github.com/jubianchi/dotfiles "$DOTFILES_TARGET_DIR"
	cd "$DOTFILES_TARGET_DIR" && git submodule update --init --recursive
else
	cd "$DOTFILES_TARGET_DIR" && git pull origin
	cd "$DOTFILES_TARGET_DIR" && git submodule update --recursive
fi

which brew || ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)" \
	&& brew bundle $DOTFILES_TARGET_DIR/Brewfile \
	&& brew bundle $DOTFILES_TARGET_DIR/Caskfile
