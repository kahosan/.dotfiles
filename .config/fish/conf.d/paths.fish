function fish_add_path_safe
    if test -d $argv[1]
        fish_add_path $argv[1]
    end
end

fish_add_path_safe /usr/local/sbin
fish_add_path_safe ~/.local/bin
fish_add_path_safe ~/.cargo/bin
fish_add_path_safe ~/.pnpm-global/bin


if test (uname) = Darwin
    fish_add_path /opt/homebrew/bin
    fish_add_path /opt/homebrew/sbin
    fish_add_path_safe (brew --prefix python@3.11)/libexec/bin
    fish_add_path_safe /opt/homebrew/opt/libpq/bin
end

if test (uname) = Linux
    fish_add_path_safe /usr/local/go/bin
    fish_add_path_safe ~/.local/share/pnpm
    fish_add_path_safe ~/.local/share/fnm
end

if type -q go
    fish_add_path (go env GOPATH)/bin
end
