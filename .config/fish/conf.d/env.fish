set -gx XDG_CONFIG_HOME $HOME/.config
set -gx XDG_DATA_HOME $HOME/.local/share
set -gx XDG_CACHE_HOME $HOME/.cache

set -gx GOPATH $XDG_DATA_HOME/go
set -gx PNPM_HOME $XDG_DATA_HOME/pnpm

fish_add_path $PNPM_HOME

fish_add_path $HOME/.local/bin
fish_add_path $HOME/.cargo/bin
fish_add_path $XDG_CONFIG_HOME/scripts

if type -q go
    fish_add_path (go env GOPATH)/bin
end

if test (uname) = Darwin
    if test -f /opt/homebrew/bin/brew
        eval "$(/opt/homebrew/bin/brew shellenv)"
        fish_add_path /opt/homebrew/opt/libpq/bin
    end

    if test -d $HOME/.orbstack/bin
        fish_add_path $HOME/.orbstack/bin
    end
end

if test (uname) = Linux
    if test -f /home/linuxbrew/.linuxbrew/bin/brew
        eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

        set -l brew_prefix (brew --prefix)

        test -d $brew_prefix/share/fish/completions
        and set -p fish_complete_path $brew_prefix/share/fish/completions

        test -d $brew_prefix/share/fish/vendor_completions.d
        and set -p fish_complete_path $brew_prefix/share/fish/vendor_completions.d
    end
end

