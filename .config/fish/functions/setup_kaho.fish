function setup_kaho --description "setup kaho env"
    if type -q brew
        brew update
        brew install bun duf dufs fd fnm fzf mmv ripgrep sd nexttrace nali
    end
end
