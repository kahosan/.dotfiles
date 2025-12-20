function remove_path
    if set -l index (contains -i "$argv[1]" $fish_user_paths)
        set -e fish_user_paths[$index]
        echo "removed $argv[1] from the path"
    else
        echo "$argv[1] not found in fish_user_paths"
    end
end
