fish_add_path ~/.local/bin ~/.cargo/bin ~/.config/scripts

if test (uname) = Darwin
    if test -f "/opt/homebrew/bin/brew"
        eval "$(/opt/homebrew/bin/brew shellenv)"
        fish_add_path /opt/homebrew/opt/libpq/bin
    end

    if test -d "$HOME/.orbstack/bin"
        fish_add_path "$HOME/.orbstack/bin"
    end
end

if test (uname) = Linux
    if test -f "/home/linuxbrew/.linuxbrew/bin/brew"
        eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

        if test -d (brew --prefix)"/share/fish/completions"
            set -p fish_complete_path (brew --prefix)/share/fish/completions
        end

        if test -d (brew --prefix)"/share/fish/vendor_completions.d"
            set -p fish_complete_path (brew --prefix)/share/fish/vendor_completions.d
        end
    end

end

if type -q go
    fish_add_path (go env GOPATH)/bin
end
