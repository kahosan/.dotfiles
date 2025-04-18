if type -q pnpm
    set -gx PNPM_HOME "$HOME/.local/share/pnpm"
    fish_add_path "$HOME/.local/share/pnpm"
end
