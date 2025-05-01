# remove welcome
set fish_greeting

# fish color
set fish_color_command green
set fish_color_error brred

# vscode shell integrated
if status is-interactive
    if type -q starship
        starship init fish | source
    end

    string match -q "$TERM_PROGRAM" vscode
    and . (code --locate-shell-integration-path fish)
end

# bat
set -x BAT_THEME "Nord"
set -x BAT_STYLE changes

set -x EDITOR nvim

# ni
set -x NI_CONFIG_FILE ~/.config/ni/nirc

# fnm
if type -q fnm
    fnm env --use-on-cd --shell fish | source
end

# homebrew not auto update
set -x HOMEBREW_NO_AUTO_UPDATE 1

# LANG
set -x LANG en_US.UTF-8

# corepack
set -x COREPACK_ENABLE_AUTO_PIN 0

# ssh
alias nas "kitty +kitten ssh kaho@10.88.88.106"

# alias
alias vim nvim
alias ls "eza --git --icons"
alias ll "ls --long --time-style=long-iso"
alias l ll
alias la "ls -a"
alias lla "ll -a"
alias df duf
alias python python3
alias pip pip3
alias c clear
alias cl clear
alias bry hexyl
alias nio "ni --prefer-offline"
alias refish "source ~/.config/fish/config.fish"
alias hr 'history --merge'
alias dc 'docker compose'

# kitty
alias kssh "kitty +kitten ssh"
alias icat="kitten icat"
alias kd="kitten diff"

# git alias
alias glo "git log --graph --pretty=format:'%C(auto)%h -%Creset %d %s %Cgreen(%cr)%Creset' --abbrev-commit"
alias gcm "git checkout main"
alias gcb "git checkout -b"
alias gc "git checkout"
alias gp "git push"
alias gpf 'git push --force'
alias gl "git pull"
alias gpl "git pull --rebase"

alias main 'git checkout main'

# my
alias gs "git status"
alias gap "git add -p"
alias gm "git commit"
alias gds "git diff --staged"

# dns tools
function nsl
    nslookup $argv | nali
end

function digl
    dig $argv | nali
end

# node action
# alias s "nr start"
alias d "nr dev"
alias b "nr build"
alias bw "nr build --watch"
alias t "nr test"
alias tu "nr test -u"
alias tw "nr test --watch"
alias nw "nr watch"
alias p "nr play"
alias lint "nr lint"
alias lintf "nr lint --fix"
alias release "nr release"
alias re "nr release"

# rust
alias r "cargo run"
alias rr "cargo run --release"

# custom
alias ntr nexttrace

# https://github.com/sindresorhus/trash-cli
# or use default rm -i
if type trash >/dev/null 2>&1
    alias rm trash
else
    alias rm 'rm -i'
end

# function
function yy
    set tmp (mktemp -t "yazi-cwd.XXXXXX")
    yazi $argv --cwd-file="$tmp"
    if set cwd (cat -- "$tmp"); and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
        cd -- "$cwd"
    end
    rm -f -- "$tmp"
end
