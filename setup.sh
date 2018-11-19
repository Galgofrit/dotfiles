#!/bin/sh

# install git
# install tmux
# instal vim

# install flake8
# install pylint
# install yapf
# install autopep8


stow bash
stow git
stow tmux
stow vim
stow zsh

# vim pluginstall
# tmux prefix-I

# Set up fonts
# clone
git clone https://github.com/powerline/fonts.git --depth=1
# install
cd fonts
./install.sh
# clean-up a bit
cd ..
rm -rf fonts
