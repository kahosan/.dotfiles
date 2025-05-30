function oil
    if test -z $argv[1];
        echo "Usage: oil user@ip/path"
        return
    end

    nvim oil-ssh://$argv[1]
end

