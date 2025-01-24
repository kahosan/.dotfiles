# if status is-interactive
# Commands to run in interactive sessions can go here
#end

# remove welcome
set fish_greeting

# fish color
set fish_color_command green
set fish_color_error brred

# eza color
set -x EZA_COLORS "di=1;38;2;137;180;250:ln=38;2;137;220;235:pi=38;2;127;132;156:so=38;2;127;132;156:bd=38;2;235;160;172:cd=38;2;235;160;172:sp=38;2;203;166;247:ex=38;2;166;227;161:mp=38;2;116;199;236:\
ur=38;2;205;214;244:uw=38;2;249;226;175:ux=38;2;166;227;161:ue=38;2;166;227;161:gr=38;2;186;194;222:gw=38;2;249;226;175:gx=38;2;166;227;161:\
tr=38;2;166;173;200:tw=38;2;249;226;175:tx=38;2;166;227;161:su=38;2;203;166;247:sf=38;2;88;91;112:xa=38;2;166;173;200:\
nb=38;2;205;214;244:nk=38;2;186;194;222:nm=38;2;137;180;250:ng=38;2;203;166;247:nt=38;2;203;166;247:ub=38;2;166;173;200:\
uk=38;2;137;180;250:um=38;2;203;166;247:ug=38;2;203;166;247:ut=38;2;116;199;236:\
uu=38;2;205;214;244:uR=38;2;243;139;168:un=38;2;203;166;247:gu=38;2;186;194;222:gR=38;2;243;139;168:gn=38;2;127;132;156:\
xx=38;2;127;132;156:da=38;2;249;226;175:in=38;2;166;173;200:bl=38;2;147;153;178:hd=38;2;205;214;244:oc=38;2;148;226;213:\
fi=38;2;186;194;222:im=38;2;249;226;175:vi=38;2;243;139;168:mu=38;2;166;227;161:lo=38;2;148;226;213:\
cr=38;2;88;91;112:do=38;2;205;214;244:co=38;2;245;194;231:tm=38;2;235;160;172:\
cm=38;2;116;199;236:bu=38;2;88;91;112:sc=38;2;137;180;250:\
gn=38;2;127;132;156:gi=38;2;127;132;156:gc=38;2;235;160;172:\
Gm=38;2;205;214;244:Go=38;2;203;166;247:Gc=38;2;166;227;161:Gd=38;2;243;139;168"

# ls color
set -x LS_COLORS "*.aac=35:*.alac=35:*.ape=35:*.flac=35:*.m4a=35:*.mka=35:*.mp3=35:*.ogg=35:*.opus=35:*.wav=35:*.wma=35"

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
alias l ll
alias vim nvim
alias ls "eza --git --icons"
alias la "ls -a"
alias df duf
alias python python3
alias pip pip3
alias c clear
alias cl clear
alias bry hexyl
alias nio "ni --prefer-offline"
alias refish "source ~/.config/fish/config.fish"
alias kssh "kitty +kitten ssh"
alias hr 'history --merge'
alias logv lnav

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

# highlight help
abbr -a --position anywhere -- '-h' '-h 2>&1 | bat -plhelp'
abbr -a --position anywhere -- '--help' '--help 2>&1 | bat -plhelp'

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
