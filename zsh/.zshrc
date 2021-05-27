# User configuration

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
source ~/.aliases
source ~/.profile

# The following lines were added by compinstall

#zstyle ':completion:*' completer _expand _complete _ignored _correct _approximate
#zstyle :compinstall filename '/home/joaj/.zshrc'
zstyle ':completion:*' menu select

##### completions

# explaining the compinit -u hack:
  # the compinit -u hack is called for because I run the shell as a docker image
  # and mount the dotfiles repo as a volume. Compinit gets angry at me because
  # when docker mounts the volume, the permissions are wrong.
  # So when you run `exec zsh`, for exemple, compinit gets angry at you by saying:
  # "zsh compinit: insecure directories and files, run compaudit for list."
  # The -u flag tells compinit to be silent about that.
  # more info here: http://stackoverflow.com/a/19601821/4921402
# comp bootstrap
autoload -Uz compinit && compinit -u
autoload bashcompinit

# case insensitive completion
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'

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


#bindkey -v

autoload -Uz promptinit
autoload -Uz compinit prompinit
compinit
promptinit

# End of lines added by compinstall
# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000
setopt extendedglob nomatch notify
# End of lines configured by zsh-newuser-install

RPROMPT='%?'

autoload -Uz run-help
alias help=run-help

#source /usr/share/doc/pkgfile/command-not-found.zsh

#export KEYTIMEOUT=1

setopt prompt_subst
autoload -Uz vcs_info
zstyle ':vcs_info:*' stagedstr 'M' 
zstyle ':vcs_info:*' unstagedstr 'M' 
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' actionformats '%F{5}[%F{2}%b%F{3}|%F{1}%a%F{5}]%f '
zstyle ':vcs_info:*' formats \
  '%F{5}[%F{2}%b%F{5}] %F{2}%c%F{3}%u%f'
zstyle ':vcs_info:git*+set-message:*' hooks git-untracked
zstyle ':vcs_info:*' enable git 
+vi-git-untracked() {
  if [[ $(git rev-parse --is-inside-work-tree 2> /dev/null) == 'true' ]] && \
  [[ $(git ls-files --other --directory --exclude-standard | sed q | wc -l | tr -d ' ') == 1 ]] ; then
  hook_com[unstaged]+='%F{1}??%f'
fi
}

function zle-line-init zle-keymap-select {
    VIM_PROMPT="%{$fg_bold[yellow]%}[% NORMAL]% %{$reset_color%}"

	PROMPT="[%F{red}%n@%M%F{white}] [%F{green}%T%F{white}] [%F{yellow}%~%F{white}] ${${KEYMAP/vicmd/$VIM_PROMPT}/(main|viins)/[INSERT]} $EPS1
 %F{white}-> %F{grey}"
    #PROMPT="${${KEYMAP/vicmd/$VIM_PROMPT}/(main|viins)/[INSERT]} %? $EPS1"
    zle reset-prompt
}
#PROMPT="${${KEYMAP/vicmd/$VIM_PROMPT}/(main|viins)/} %? $EPS1"

PROMPT=$'[%F{red}%n@%M%F{white}] [%F{green}%T%F{white}] [%F{yellow}%~%F{white}] ${${KEYMAP/vicmd/$VIM_PROMPT}/(main|viins)/[INSERT]} %? $EPS1
 %F{white}->%F{014} %{\e[0m%}'
zle -N zle-line-init
zle -N zle-keymap-select


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

/home/joaj/bin/gruvbox
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

#source /etc/profile.d/autojump.zsh

#export PATH=/home/joaj/bin:/usr/local/sbin:/usr/local/bin:/usr/bin:/opt/microchip/xc16/v1.33/bin:/usr/bin/site_perl:/usr/bin/vendor_perl:/usr/bin/core_perl:/home/joaj/go/bin:/home/joaj/.gem/ruby/2.4.0/bin:/home/joaj/bin:/home/joaj/.gem/ruby/2.6.0/bin:/opt/ros/kinetic/bin:/home/joaj/sat/Software/src/scripts:/opt/ti/ccs910/ccs/tools/compiler/msp430-gcc-8.2.0.52_linux64/bin
#
#export PATH=$PATH:/home/joaj/.local/bin
#source /opt/ros/kinetic/setup.zsh
#source /home/joaj/ros_ws/devel/setup.zsh

source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

#export DISABLE_AUTO_TITLE='true'
#compctl -g '~/.teamocil/*(:t:r)' teamocil

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=7'
#source ~/powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
#[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
#
#eval "$(starship init zsh)"

#source ~/bin/mouse.zsh
#zle-toggle-mouse
if [ -e /home/joaj/.nix-profile/etc/profile.d/nix.sh ]; then . /home/joaj/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer



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

set_title "uxterm"
#eval "$(starship init zsh)"
