#!/bin/bash

# ---
# Utilities

OS=$(uname)

if [ "$OS" = "Darwin" ]; then
    PKG_MANAGER="brew install"
elif [ "$OS" = "Linux" ]; then
    if [ $(lsb_release -is) = "Raspbian" ] || \
        [ $(lsb_release -is) = "Debian" ] || \
        [ $(lsb_release -is) = "Ubuntu" ]; then
        PKG_MANAGER="sudo apt-get install -y"
    fi
else
    echo "Unsupported OS."
    exit 1
fi

function install ()
{
    echo "Installing $1."
    eval "$PKG_MANAGER $1"
}


# ---
# Setup
echo "Installing Brew..."
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

echo "Setting up environment..."
install git
install tmux
install vim
install stow

# Stow Zsh before installing it to avoid conflict
stow zsh
install zsh

if [ "$OS" = "Darwin" ]; then
    install the_silver_searcher
elif [ "$OS" = "Linux" ]; then
    install silversearcher-ag
fi
install ctags

# Language style/linting
install flake8
install pylint
install yapf
install autopep8
install cmake
jedi vim support

#Install OhMyZsh
echo "Installing oh my zsh..."
curl -Lo install.sh https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh
sh install.sh
rm install.sh

#pip3 install jedi TODO

stow bash
stow git
stow tmux
stow vim

vim -E -c PlugUpdate -c q # Update vim-plugged
vim -E -c PlugInstall -c q # Install all Vim plugins

# Install YouCompleteMe
echo "Installing YCM..."
~/.vim/plugged/YouCompleteMe/third_party/ycmd/build.py --clang-completer

~/.tmux/plugins/tpm/scripts/install_plugins.sh # Install Tmux plugins

# Set up fonts
git clone https://github.com/powerline/fonts.git --depth=1
cd fonts
./install.sh
cd ..
rm -rf fonts

echo "Finished setting up environment."
exit 0
