#!/bin/sh

OS=$(uname)

if [ "$OS" = "Darwin" ]; then
    PKG_MANAGER="brew install"
elif [ "$OS" = "Linux" ]; then
    if [ $(lsb_release -is) = "Raspbian" ] || \
        [ $(lsb_release -is) = "Debian" ] || \
        [ $(lsb_release -is) = "Ubuntu" ]; then
        PKG_MANAGER="apt get install "
    fi
else
    echo "Unsupported OS."
    exit 1
fi


echo $PKG_MANAGER
exit 0

# install git
# install tmux
# instal vim
# install stow

# install ag the silver searcher
# install ctags
# install fzf # ! NOT  REQUIRED, INSTALLED VIA VIM PLUG

# install flake8
# install pylint
# install yapf
# install autopep8
# jedi vim support

#pip3 install jedi

#brew install codequery
#sudo pip install pyscope


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
