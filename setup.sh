#!/bin/bash

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
echo "Setting up environment..."
install git
install tmux
install vim
install stow

if [ "$OS" = "Darwin" ]; then
    install the_silver_searcher
elif [ "$OS" = "Linux" ]; then
    install silversearcher-ag
fi
install ctags
# install fzf # not required, installed via vimplug

# Language style/linting
install flake8
install pylint
install yapf
install autopep8
jedi vim support

#pip3 install jedi

stow bash
stow git
stow tmux
stow vim
stow zsh

vim -E -c PlugUpdate -c q # Update vim-plugged
vim -E -c PlugInstall -c q # Install all Vim plugins
~/.tmux/plugins/tpm/scripts/install_plugins.sh # Install Tmux plugins

# Set up fonts
git clone https://github.com/powerline/fonts.git --depth=1
cd fonts
./install.sh
cd ..
rm -rf fonts

echo "Finished setting up environment."
exit 0
