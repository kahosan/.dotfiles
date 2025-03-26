fish_add_path ~/.local/bin
fish_add_path ~/.cargo/bin
fish_add_path ~/.pnpm-global/bin

if test (uname) = Darwin
    fish_add_path /opt/homebrew/bin
    fish_add_path /opt/homebrew/sbin
    fish_add_path /opt/homebrew/opt/libpq/bin
end

if test (uname) = Linux
end

if type -q go
    fish_add_path (go env GOPATH)/bin
end
