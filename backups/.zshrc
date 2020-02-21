# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi
ZSH_THEME="powerlevel10k/powerlevel10k"

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

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
