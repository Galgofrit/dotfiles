# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:$PATH
# export PATH=$PATH:$HOME/Library/Python/2.7/bin
# Path to your oh-my-zsh installation.
export ZSH="/Users/galg/.oh-my-zsh"

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Set list of themes to load
# Setting this variable when ZSH_THEME=random
# cause zsh load theme from this variable instead of
# looking in ~/.oh-my-zsh/themes/
# An empty array have no effect
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case # sensitive completion must be off. _ and - will be interchangeable.  # HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.  # ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.  # DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  git
  shrink-path
  brew
)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"
export PYTHONHTTPSVERIFY=0

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
 if [[ -n $SSH_CONNECTION ]]; then
   export EDITOR='vim'
 else
   export EDITOR='vim'
 fi


export HOMEBREW_GITHUB_API_TOKEN=67949c42a8cdf30cfc42276a0e60255cb09a4161

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Locale, otherwise prompt is scrambled
export LC_CTYPE=en_US.UTF-8
export LC_ALL=en_US.UTF-8

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

if [[ -f "/usr/local/bin/mvim" ]]; then
    alias vim="/usr/local/bin/mvim -v"
    alias mvim="/usr/local/bin/mvim -v"
fi

alias vi=vim
alias hexer="vim +Vinarise"
alias bt=BluetoothDeviceConnector
alias xm3="BluetoothDeviceConnector 70-26-05-e0-a6-94"
alias less="less -iSR" # -i: searches case insensitive, -S: wrap, -R: retain raw color
alias to_win="/Users/galg/coding/kvm_controller/to_win.sh"

alias library="cd /Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include"
alias syscall="sudo dtrace -lP syscall"
alias ida64="open -a /Applications/IDA\ Pro\ 7.4/ida64.app --"
alias ida="open -a /Applications/IDA Pro 7.4/ida.app --"
alias lldb='PATH=/usr/bin:$PATH lldb'

alias tree="git log --oneline --graph --decorate --all"
alias branch-authors="git for-each-ref --format='%(committerdate) %09 %(authorname) %09 %(refname)' | sort -k5n -k2M -k3n -k4n | less"

# setopt prompt_subst
# PS1='%n@%m $(shrink_path -f)>'

# View man with vim

# export MANPAGER="env MAN_PN=1 mvim -v -M +MANPAGER -"

# SentinelOne 
export PATH=$PATH:/Users/galg/coding/ida_similarity
export PATH="/Users/galg/coding/osxresearch/tools/cloud-blacklist:$PATH"
export PATH=$PATH:/Users/galg/coding/errno
export PATH=$PATH:/Users/galg/shortcuts
export PATH=$PATH:/Users/galg/Applications/SearchBin
export PATH=$PATH:/Users/galg/coding/osxresearch/diff_binaries/bin


build_agent() {
    mv /Users/galg/coding/macos-agent/distribution/scripts/universal_creator.sh /Users/galg/coding/macos-agent/distribution/scripts/universal_creator.sh.old
    echo "" > /Users/galg/coding/macos-agent/distribution/scripts/universal_creator.sh
    chmod +x /Users/galg/coding/macos-agent/distribution/scripts/universal_creator.sh
    /Users/galg/coding/macos-agent/build.sh --debug
    ret_val=$?
    if [ $ret_val -eq 0 ]; then
        osascript -e 'display notification "Finished building Sentinel agent ('$ret_val')." with title "Compilation Finished"'
        open '/Users/galg/coding/macos-agent/distribution/build/Debug_artifacts/'
    else
        osascript -e 'display notification "Could not build Sentinel agent ('$ret_val')." with title "Compilation Failed"'
    fi
    #mv /Users/galg/coding/macos-agent/distribution/scripts/universal_creator.sh.old /Users/galg/coding/macos-agent/distribution/scripts/universal_creator.sh
}

build_agent_testing() {
    mv /Users/galg/coding/macos-agent/distribution/scripts/universal_creator.sh /Users/galg/coding/macos-agent/distribution/scripts/universal_creator.sh.old
    echo "" > /Users/galg/coding/macos-agent/distribution/scripts/universal_creator.sh
    chmod +x /Users/galg/coding/macos-agent/distribution/scripts/universal_creator.sh
    /Users/galg/coding/macos-agent/build.sh --testing
    ret_val=$?
    if [ $ret_val -eq 0 ]; then
        osascript -e 'display notification "Finished building Sentinel agent ('$ret_val')." with title "Compilation Finished"'
        open '/Users/galg/coding/macos-agent/distribution/build/Testing_artifacts/'
    else
        osascript -e 'display notification "Could not build Sentinel agent ('$ret_val')." with title "Compilation Failed"'
    fi
    #mv /Users/galg/coding/macos-agent/distribution/scripts/universal_creator.sh.old /Users/galg/coding/macos-agent/distribution/scripts/universal_creator.sh
}


alias sm=~/scan_macho
alias smp="sm print --signatures ~/coding/macos-assets/signatures.plist"
alias sms="sm scan --signatures ~/coding/macos-assets/signatures.plist --whitelist ~/Malware\ Land --file"

alias smp-agent="sm print --signatures ~/coding/macos-agent/submodules/assets/signatures.plist"
alias sms-agent="sm scan --signatures ~/coding/macos-agent/submodules/assets/signatures.plist --whitelist ~/Malware\ Land --file"

alias smp-kl="sm print --signatures ~/coding/macos-agent/bundle/sentinel-agent/signatures.plist"
alias sms-kl="sm scan --signatures ~/coding/macos-agent/bundle/sentinel-agent/signatures.plist --whitelist ~/Malware\ Land --file"
alias sms-safe="find . -exec /Users/galg/scan_macho scan --signatures /Users/galg/coding/osxagent/submodules/assets/signatures.plist --file {} \;"

diff_binary_sections() {
    diff -y <(r2 -q -c 'iS entropy,md5' $1 | awk '{print $7" "$8" "$NF}') <(r2 -q -c 'iS entropy,md5' $2 | awk '{print $7" "$8" "$NF}')
}

alias hexlify="/Users/galg/coding/hexlify.py"
alias signature="codesign -dv --verbose=4"
alias mview="/Applications/MachOView.app/Contents/MacOS/MachOView"
alias readlink="greadlink"
alias sigtypes="~/sentinel/signature_types.sh | less"
alias view-logs="log show system_logs.logarchive | grep sentinel | vim - "

alias vpn_connect="sudo bash -c '/Users/galg/coding/vpn.sh &'"

alias curatheme='cd ~/Library/Application Support/cura/'
# Dark theme for Slack - apply after Slack updates
alias slackdark='cat ~/slack_dark_theme.js >> /Applications/Slack.app/Contents/Resources/app.asar.unpacked/src/static/ssb-interop.js'

source ~/.python_path

# powerline
# . /Users/galg/Library/Python/2.7/lib/python/site-packages/powerline/bindings/zsh/powerline.zsh


# FZF
export FZF_DEFAULT_COMMAND='ag -g ""'

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export PATH="/usr/local/opt/bison/bin:$PATH"
export PATH="/Users/galg/jtool:$PATH"
export PATH="/Users/galg/coding/ddcctl:$PATH"
export PATH="/opt/metasploit-framework/bin:$PATH"
export PATH="/Users/galg/coding/tools/bindiff/bin:$PATH"
export PATH="/usr/local/opt/openjdk/bin:$PATH"
export PATH="/Users/galg/coding/uniqsymz:$PATH"

# source /Users/galg/Library/Preferences/org.dystroy.broot/launcher/bash/br

setopt noincappendhistory # Don't share history between Tmux panes
setopt nosharehistory
