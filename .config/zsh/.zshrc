# ABOUT: ZSHRC
# AUTHOR: WantGuns <mail@wantguns.dev>

# Sane Defaults
autoload -U colors && colors	# Load colors
setopt interactivecomments      # Use comments

# Persist History
HISTFILE=~/.local/zsh/zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory

# Plugins
source $ZDOTDIR/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source $ZDOTDIR/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source $ZDOTDIR/plugins/zsh-sudo/sudo.plugin.zsh

# exports
export EDITOR=nvim
export PATH="$PATH:$HOME/.local/scripts"

# helper functions
mcd() {
    mkdir -p "$1"
    cd "$1"
}

paste() {
    local file=${1:-/dev/stdin}
    curl --data-binary @${file} https://bin.wantguns.dev | tee >(xclip -selection clipboard)
}

sharkbait() {
    ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no -l root -i ~/.ssh/sb/id_ed25519 lavender $@
}

# aliases
alias grep='rg'
alias vim='nvim'
alias cfgz='nvim ~/.config/zsh/.zshrc'
alias cfgt='nvim ~/.config/tmux/tmux.conf'
alias cfgn='nvim ~/.config/nvim/init.vim'
alias srcz='source ~/.config/zsh/.zshrc'
alias ls='ls --color=auto'
alias gsudo='sudo git -c "include.path='"${XDG_CONFIG_DIR:-$HOME/.config}/git/config\""
alias tmux='tmux -f "$XDG_CONFIG_HOME"/tmux/tmux.conf' # y u do dis tmux
alias config='/usr/bin/git --git-dir=$HOME/.dots/ --work-tree=$HOME'
alias vm='sudo virsh'
alias gallifrey='ssh root@g.wantguns.dev -p 4081'
alias ssh='SSH_AUTH_SOCK= ssh -i ~/.ssh/gallifrey'


# Command completion
autoload -Uz compinit
zstyle ':completion:*' menu select
compinit
zmodload zsh/complist
_comp_options+=(globdots)		# Include hidden files.

# Source Keybindings
source $ZDOTDIR/keybindings.zsh

# Edit line in vim with ctrl-e:
autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line

# Prompt
autoload -Uz promptinit
autoload -Uz vcs_info
precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )
setopt prompt_subst
setopt inc_append_history
# setopt SHARE_HISTORY
# setopt EXTENDED_HISTORY
promptinit
PROMPT='%F{yellow}[%m] %B%F{cyan}%n%b% %F{magenta}${vcs_info_msg_0_}%(?.. %F{red}%?):%E ' # boldface username
RPROMPT='%F{white}%~' # current directory

# git prompt 
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' unstagedstr '!'
zstyle ':vcs_info:*' stagedstr '+'
zstyle ':vcs_info:*' formats ' %b%u%c'
