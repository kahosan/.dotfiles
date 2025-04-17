function setup_kaho --description "setup kaho env"
    if type -q brew
        brew update
        brew install dufs fd fnm fzf ripgrep sd eza pnpm pipe-rename nali
    end
end
