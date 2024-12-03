function setup_docker --description 'setup docker'
    set -l os_name $argv[1]

    if test "$os_name" = ubuntu; or test "$os_name" = debian
        sudo apt-get update
        sudo apt-get install ca-certificates curl
        sudo install -m 0755 -d /etc/apt/keyrings
        sudo curl -fsSL https://download.docker.com/linux/$os_name/gpg -o /etc/apt/keyrings/docker.asc
        sudo chmod a+r /etc/apt/keyrings/docker.asc

        set -l arch (dpkg --print-architecture)
        set -l version_codename (cat /etc/os-release | grep '^VERSION_CODENAME=' | sed 's/VERSION_CODENAME=//')
        echo "deb [arch=$arch signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/debian $version_codename stable" | sudo tee /etc/apt/sources.list.d/docker.list >/dev/null

        sudo apt-get update
    end

    echo "unsupported OS"
    return 1
end
