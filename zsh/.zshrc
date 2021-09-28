export PATH="/opt/homebrew/bin/:$PATH"

fpath=($ZDOTDIR/external $fpath)

source "$XDG_CONFIG_HOME/zsh/aliases"

zmodload zsh/complist

bindkey 'jk' vi-cmd-mode
bindkey 'kj' vi-cmd-mode

bindkey -M menuselect j vi-backward-char
bindkey -M menuselect k vi-down-line-or-history
bindkey -M menuselect l vi-up-line-or-history
bindkey -M menuselect \; vi-forward-char

bindkey -a j vi-backward-char
bindkey -a k vi-down-line-or-history
bindkey -a l vi-up-line-or-history
bindkey -a \; vi-forward-char

autoload -Uz compinit; compinit
_comp_options+=(globdots) # With hidden files
source ~/dotfiles/zsh/external/completion.zsh

autoload -Uz prompt_purification_setup; prompt_purification_setup

# Push the current directory visited on to the stack.
setopt AUTO_PUSHD
# Do not store duplicate directories in the stack
setopt PUSHD_IGNORE_DUPS
# Do not print the directory stack after using
setopt PUSHD_SILENT

bindkey -v
export KEYTIMEOUT=1

autoload -Uz cursor_mode && cursor_mode

autoload -Uz edit-command-line
zle -N edit-command-line
bindkey -M vicmd v edit-command-line

source ~/dotfiles/zsh/external/bd.zsh

if [ $(command -v "fzf") ]; then
    source /opt/homebrew/Cellar/fzf/0.27.2/shell/completion.zsh
    source /opt/homebrew/Cellar/fzf/0.27.2/shell/key-bindings.zsh
fi

if [ "$(tty)" = "/dev/tty1" ];
then
    pgrep i3 || exec startx "$XDG_CONFIG_HOME/X11/.xinitrc"
fi

source $DOTFILES/zsh/scripts.sh

ftmuxp

# Clearing the shell is now done with CTRL+p
bindkey -r '^l'
bindkey -r '^p'
bindkey -s '^p' 'clear\n'

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/pchabros/miniforge3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/pchabros/miniforge3/etc/profile.d/conda.sh" ]; then
        . "/Users/pchabros/miniforge3/etc/profile.d/conda.sh"
    else
        export PATH="/Users/pchabros/miniforge3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<
# Node Version Manager
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# suntax highlighting
source "$DOTFILES/zsh/external/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
export CLICOLOR=YES
test -r ~/.dir_colors && eval $(gdircolors ~/.dir_colors)

