# Source the common bash/zsh aliases
source ~/.aliases
source ~/.profile

# The following lines were added by compinstall

zstyle ':completion:*' menu select

#info here: http://stackoverflow.com/a/19601821/4921402
autoload -Uz compinit && compinit -u
autoload bashcompinit

### fuzzy completion
# lifted from http://superuser.com/a/815317/555734
# 0 -- vanilla completion (abc => abc)
# 1 -- smart case completion (abc => Abc)
# 2 -- word flex completion (abc => A-big-Car)
# 3 -- full flex completion (abc => ABraCadabra)
zstyle ':completion:*' matcher-list '' \
  'm:{a-z\-}={A-Z\_}' \
  'r:[^[:alpha:]]||[[:alpha:]]=** r:|=* m:{a-z\-}={A-Z\_}' \
  'r:[[:ascii:]]||[[:ascii:]]=** r:|=* m:{a-z\-}={A-Z\_}'

# colors: magenta, green, blue,cyan, yellow, red
zstyle ':completion:*:functions' ignored-patterns '_*'
zstyle ':completion:*' format $'\n%F{yellow}Completing %d%f\n'
zstyle ':completion:*' group-name ''

autoload -Uz promptinit
autoload -Uz compinit prompinit
compinit
promptinit

# End of lines added by compinstall

# Shell history
export HISTFILE="$XDG_STATE_HOME"/zsh/history
HISTSIZE=100000
SAVEHIST=100000
setopt extendedglob nomatch notify extended_history

# Show return code on the right side of the prompt
RPROMPT='%?'

autoload -Uz run-help
alias help=run-help

#setopt prompt_subst

#function zle-line-init zle-keymap-select {
#    VIM_PROMPT="%{$fg_bold[yellow]%}[% NORMAL]% %{$reset_color%}"
#
#	PROMPT="[%F{red}%n@%M%F{white}] [%F{green}%T%F{white}] [%F{yellow}%~%F{white}] ${${KEYMAP/vicmd/$VIM_PROMPT}/(main|viins)/[INSERT]} $EPS1
# %F{white}-> %F{grey}"
#    zle reset-prompt
#}

#PROMPT=$'[%F{red}%n@%M%F{white}] [%F{green}%T%F{white}] [%F{yellow}%~%F{white}] ${${KEYMAP/vicmd/$VIM_PROMPT}/(main|viins)/[INSERT]} %? $EPS1
# %F{white}->%F{014} %{\e[0m%}'
#zle -N zle-line-init
#zle -N zle-keymap-select



# Use vim cli mode
bindkey '^P' up-history
bindkey '^N' down-history

# backspace and ^h working even after
# returning from command mode
bindkey '^?' backward-delete-char
bindkey '^h' backward-delete-char

# ctrl-w removed word backwards
bindkey '^w' backward-kill-word

# ctrl-r starts searching history backward
bindkey '^r' history-incremental-search-backward
autoload edit-command-line; zle -N edit-command-line
bindkey -M vicmd v edit-command-line

[ -f /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ] && source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

[ -f $XDG_CONFIG_HOME/fzf/fzf.zsh ] && source $XDG_CONFIG_HOME/fzf/fzf.zsh

[ -f /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh ] && source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=7'


# zoxide
_z_cd() {
    cd "$@" || return "$?"

    if [ "$_ZO_ECHO" = "1" ]; then
        echo "$PWD"
    fi
}

z() {
    if [ "$#" -eq 0 ]; then
        _z_cd ~
    elif [ "$#" -eq 1 ] && [ "$1" = '-' ]; then
        if [ -n "$OLDPWD" ]; then
            _z_cd "$OLDPWD"
        else
            echo 'zoxide: $OLDPWD is not set'
            return 1
        fi
    else
        _zoxide_result="$(zoxide query -- "$@")" && _z_cd "$_zoxide_result"
    fi
}

zi() {
    _zoxide_result="$(zoxide query -i -- "$@")" && _z_cd "$_zoxide_result"
}

alias za='zoxide add'
alias zq='zoxide query'
alias zqi='zoxide query -i'
alias zr='zoxide remove'

zri() {
    _zoxide_result="$(zoxide query -i -- "$@")" && zoxide remove "$_zoxide_result"
}

_zoxide_hook() {
    zoxide add "$(pwd -L)"
}

chpwd_functions=(${chpwd_functions[@]} "_zoxide_hook")

set_title()
{
    echo -n "\033]0;$1\007"
}

# XDG compliance
compinit -d "$XDG_CACHE_HOME"/zsh/zcompdump-"$ZSH_VERSION"


eval "$(starship init zsh)"
