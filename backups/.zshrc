# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi
ZSH_THEME="powerlevel10k/powerlevel10k"

export TERM="xterm-256color"

# _ and - will be interchangeable.
HYPHEN_INSENSITIVE="true"

# Enable command auto-correction.
ENABLE_CORRECTION="false"

# zsh插件
export ZSH="$HOME/.oh-my-zsh"
plugins=(zsh-autosuggestions zsh-syntax-highlighting autojump)

# 网络代理配置
function fq() {
    export http_proxy=http://127.0.0.1:1087
    export https_proxy=http://127.0.0.1:1087
    echo -e "已开启代理"
}
function zl() {
    unset http_proxy
    unset https_proxy
    echo -e "已关闭代理"
}

# 设置别名
alias tree="tree -N"

COMPLETION_WAITING_DOTS="true"
ZSH_DISABLE_COMPFIX="true"

source $ZSH/oh-my-zsh.sh

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

# config localhost https for develop
# export NODE_EXTRA_CA_CERTS="$(mkcert -CAROOT)/rootCA.pem"

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=magenta,bold"
