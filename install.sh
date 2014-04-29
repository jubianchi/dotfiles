#!/bin/bash

DOTFILES_TARGET_DIR=${DOTFILES_TARGET_DIR-$HOME/.dotfiles}
DOTFILES_TARGET_DIR=${1-$DOTFILES_TARGET_DIR}

for package in "coreutils git reattach-to-user-namespace homebrew/dupes/grep openssl tmux highlight tig ctags"
do
	brew install $package --default-names
done

if [ ! -d "$DOTFILES_TARGET_DIR" ]
then
	git clone https://github.com/jubianchi/dotfiles "$DOTFILES_TARGET_DIR"
	cd "$DOTFILES_TARGET_DIR" && git submodule update --init --recursive
else
	cd "$DOTFILES_TARGET_DIR" && git pull origin
	cd "$DOTFILES_TARGET_DIR" && git submodule update --recursive
fi
