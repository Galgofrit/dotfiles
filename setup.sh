#!/bin/bash

# ---
# Utilities

OS=$(uname)

if [ "$OS" = "Darwin" ]; then
    BREW_PATH=/opt/homebrew/bin/brew
    PKG_MANAGER="$BREW_PATH install"
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

# Install Homebrew
if [ "$OS" = "Darwin" ]; then
    if [ -f "$BREW_PATH" ]; then
        echo "Brew already installed on the system. Proceeding..."
    else
        echo "Installing Brew..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
    fi
fi

echo "Setting up environment..."

if [ "$OS" = "Darwin" ]; then
    # MacOS Specifics
    install the_silver_searcher
    brew install https://raw.githubusercontent.com/Homebrew/homebrew-core/86a44a0a552c673a05f11018459c9f5faae3becc/Formula/python@2.rb # Python 2
elif [ "$OS" = "Linux" ]; then
    # Linux Specifics
    install silversearcher-ag
fi

install python # Python 3
install git
install tmux
install vim
install stow

stow zsh # Stow Zsh before installing it to avoid conflict
install zsh
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
stow pylint

mkdir ~/.vim/undodir # Set up directory for Vim undo history

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
echo "Change fonts for terminal emulator now, to 'Droid Sans Mono for Powerline', size 14."

echo "Finished setting up environment."
exit 0
