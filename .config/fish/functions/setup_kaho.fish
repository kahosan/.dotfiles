function setup_kaho --description "setup kaho env"
    if type -q brew
        brew update
        brew install dufs fd fnm fzf mmv ripgrep sd eza pnpm
    end
end
