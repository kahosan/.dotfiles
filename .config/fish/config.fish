# if status is-interactive
# Commands to run in interactive sessions can go here
#end

# remove welcome
set fish_greeting

# PATH
fish_add_path ~/.local/bin
fish_add_path $(go env GOPATH)/bin
fish_add_path ~/.pnpm-global/bin

# ni
set -x NI_CONFIG_FILE ~/.config/ni/nirc

# fnm
fnm env --use-on-cd | source

# starship
starship init fish | source

# LANG
set -x LANG en_US.UTF-8

# ssh
alias nas="ssh kaho@10.88.88.106"

# alias
alias l="ll"
alias vim="nvim"
alias ls="exa"
alias la="exa -a"
alias df="duf"
alias python="python3"
alias pip="pip3"
alias c="clear"
alias cl="clear"
alias bry="hexyl"
alias nio="ni --prefer-offline"
alias refish="source ~/.config/fish/config.fish"

# git alias
alias glo="git log --oneline --graph"
alias gcm="git checkout master"
alias gcb="git checkout -b"
alias gc="git checkout"
alias gp="git push"
alias gl="git pull"

# custom

# https://github.com/sindresorhus/trash-cli
# or use default rm -i
if type trash >/dev/null 2>&1
  alias rm='trash'
else
  alias rm='rm -i'
end

# tabtab source for packages
# uninstall by removing these lines
[ -f ~/.config/tabtab/fish/__tabtab.fish ]; and . ~/.config/tabtab/fish/__tabtab.fish; or true
