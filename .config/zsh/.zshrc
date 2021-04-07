# ABOUT: ZSHRC
# AUTHOR: WantGuns <mail@wantguns.dev>

# p10k
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Sane Defaults
autoload -U colors && colors	# Load colors
setopt interactivecomments      # Use comments
# Persist History
HISTFILE=~/.local/zsh/zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory
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


# Plugins
source $ZDOTDIR/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source $ZDOTDIR/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source $ZDOTDIR/plugins/zsh-sudo/sudo.plugin.zsh

# FZF
export FZF_DEFAULT_OPTS="--layout=reverse --height 50%"

# exports
export EDITOR=nvim
export PATH="$PATH:$HOME/.local/scripts"
export PATH="$PATH:$HOME/.local/bin"

# use dialog boxes with cron and at 
xhost local:wantguns > /dev/null

# helper functions
mcd() { mkdir -p "$1"; cd "$1" }

paste() {
    local file=${1:-/dev/stdin}
    curl --data-binary @${file} https://bin.wantguns.dev | tee >(xclip -selection clipboard)
}

sharkbait() { ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no -l root -i ~/.ssh/sb/id_ed25519 lavender $@ }

f() {
    # fuzy find a file, and pipe it into editor
    find ~/.local/scripts ~/.config | fzf | xargs -r "$EDITOR"
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

# Prompt
source ~/.config/p10k/powerlevel10k.zsh-theme
[[ ! -f ~/.config/zsh/.p10k.zsh ]] || source ~/.config/zsh/.p10k.zsh
