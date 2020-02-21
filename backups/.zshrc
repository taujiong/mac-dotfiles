# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:$PATH
export TERM="xterm-256color"

# _ and - will be interchangeable.
HYPHEN_INSENSITIVE="true"

# Enable command auto-correction.
ENABLE_CORRECTION="false"

# zsh插件
export ZSH="$HOME/.oh-my-zsh"
plugins=(zsh-autosuggestions zsh-syntax-highlighting git autojump)

# 网络代理配置
export ssr_proxy=http://127.0.0.1:1087

function fq() {
    export http_proxy=$ssr_proxy
    export https_proxy=$ssr_proxy
    echo -e "已开启代理"
}

function zl() {
    unset http_proxy
    unset https_proxy
    echo -e "已关闭代理"
}

# 设置别名
alias tree="tree -N"

alias brewup="brew upgrade; brew cask upgrade"
alias brews="brew search"
alias brewi="brew install"
alias brewl="brew list"
alias brewu="brew uninstall"

alias brewc="brew cask"
alias brewci="brew cask install"
alias brewcl="brew cask list"
alias brewcu="brew cask uninstall"

ZSH_THEME="powerlevel10k/powerlevel10k"
POWERLEVEL9K_MODE="nerdfont-complete"
POWERLEVEL9K_PROMPT_ON_NEWLINE=true
POWERLEVEL9K_COMMAND_EXECUTION_TIME_THRESHOLD=60
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(os_icon user dir_writable dir vcs)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status command_execution_time root_indicator background_jobs history ip time)
#POWERLEVEL9K_MULTILINE_LAST_PROMPT_PREFIX="%(?:%{$fg_bold[green]%}➜ :%{$fg_bold[red]%}➜ )"
#POWERLEVEL9K_MULTILINE_FIRST_PROMPT_PREFIX=""
#POWERLEVEL9K_USER_ICON="\uF415"
POWERLEVEL9K_ROOT_ICON="\uF09C"
#POWERLEVEL9K_SUDO_ICON=$'\uF09C'
POWERLEVEL9K_TIME_FORMAT="%D{%H:%M}"
#POWERLEVEL9K_VCS_GIT_ICON='\uF408 '
#POWERLEVEL9K_VCS_GIT_GITHUB_ICON='\uF408 '

ZSH_DISABLE_COMPFIX=true

ENABLE_CORRECTION="false"
COMPLETION_WAITING_DOTS="true"

source $ZSH/oh-my-zsh.sh

# source ~/.bash_profile
if [ -f ~/.bash_profile ]; then
    . ~/.bash_profile;
fi

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/usr/local/Caskroom/miniconda/base/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/usr/local/Caskroom/miniconda/base/etc/profile.d/conda.sh" ]; then
        . "/usr/local/Caskroom/miniconda/base/etc/profile.d/conda.sh"
    else
        export PATH="/usr/local/Caskroom/miniconda/base/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

# Add .NET Core SDK tools
export PATH="$PATH:$HOME/.dotnet/tools"
