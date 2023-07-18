# if status is-interactive
# Commands to run in interactive sessions can go here
#end

# remove welcome
set fish_greeting

# fish color
set fish_color_command green
set fish_color_error brred

# PATH
fish_add_path ~/.local/bin
fish_add_path ~/.cargo/bin
fish_add_path (go env GOPATH)/bin
fish_add_path ~/.pnpm-global/bin
fish_add_path /opt/homebrew/sbin
fish_add_path /opt/homebrew/bin

# ni
set -x NI_CONFIG_FILE ~/.config/ni/nirc

# fnm
fnm env --use-on-cd | source

# starship
starship init fish | source

# homebrew not auto update
set -x HOMEBREW_NO_AUTO_UPDATE 1

# LANG
set -x LANG en_US.UTF-8

# ssh
alias nas="kitty +kitten ssh kaho@10.88.88.106"

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
alias gpf='git push --force'
alias gl="git pull"
alias gpl="git pull --rebase"

alias main='git checkout main'

# my
alias gs="git status"
alias gap="git add -p"
alias gm="git commit"
alias gds="git diff --staged"


# node action
# alias s="nr start"
alias d="nr dev"
alias b="nr build"
alias bw="nr build --watch"
alias t="nr test"
alias tu="nr test -u"
alias tw="nr test --watch"
alias nw="nr watch"
alias p="nr play"
alias lint="nr lint"
alias lintf="nr lint --fix"
alias release="nr release"
alias re="nr release"

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
