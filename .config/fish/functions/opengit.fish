function opengit --description "open git repo in browser"
    if not git rev-parse --git-dir >/dev/null 2>&1
        echo "Not in a git repository"
        return 1
    end

    function crossopen
        if command -q open
            open "$argv[1]"
        else if command -q xdg-open
            xdg-open "$argv[1]"
        else if command -q wslview
            wslview "$argv[1]"
        else
            echo "Could not find a command to open the browser"
            echo "$argv[1]"
            return 1
        end
    end

    set remote_url (git config --get remote.origin.url)
    if test -z "$remote_url"
        echo "No remote 'origin' found"
        return 1
    end

    # Convert SSH URL to HTTPS if needed
    set remote_url (string replace -r '^git@([^:]+):(.+?)(?:\.git)?$' 'https://$1/$2' $remote_url)
    # Remove .git suffix if present
    set remote_url (string replace -r '\.git$' '' $remote_url)

    if test -z "$argv[1]"
        crossopen "$remote_url"
        return 0
    end

    set commit_hash (git rev-parse --short $argv[1] 2>/dev/null)
    if test $status -ne 0
        echo "Invalid commit reference '$argv[1]'"
        return 1
    end

    # Build commit URL based on hosting service
    if string match -q '*github.com*' $remote_url
        set commit_url "$remote_url/commit/$commit_hash"
    else if string match -q '*gitlab.com*' $remote_url
        set commit_url "$remote_url/-/commit/$commit_hash"
    else if string match -q '*bitbucket.org*' $remote_url
        set commit_url "$remote_url/commits/$commit_hash"
    else
        set commit_url "$remote_url/commit/$commit_hash"
    end

    crossopen "$commit_url"
end

