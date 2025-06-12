function setup_kaho --description "setup kaho env"
    if type -q brew
        brew update
        brew install fnm pnpm pipe-rename
    end
end
