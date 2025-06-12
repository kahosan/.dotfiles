if type -q pnpm
    set -x PNPM_HOME "$HOME/.local/share/pnpm"
    fish_add_path "$HOME/.local/share/pnpm"
end
