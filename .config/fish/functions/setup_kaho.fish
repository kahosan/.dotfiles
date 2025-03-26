function setup_kaho --description "setup kaho env"
    # install fnm
    if not type -q fnm
        echo "installing fnm"
        curl -fsSL https://fnm.vercel.app/install | bash -s -- --install-dir "~/.fnm" --skip-shell
        fish_add_path ~/.fnm
    end

    # install eza
    if test (uname -m) != x86_64 || test (uname) != Linux
        echo "install eza supporting only Linux x86_64"
    else if not type -q eza
        echo "installing eza"
        wget -c https://github.com/eza-community/eza/releases/latest/download/eza_x86_64-unknown-linux-gnu.tar.gz -O - | tar xz
        chmod +x eza
        mv eza ~/.local/bin
    end

    echo "Possibly needed packages: dufs, bun, nvim, nexttrace"
end
