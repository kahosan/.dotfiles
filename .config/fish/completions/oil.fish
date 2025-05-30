# Fish completion for oil-ssh command
# Save this file as ~/.config/fish/completions/oil-ssh.fish

function __oil_ssh_get_hosts
    # Extract host names from SSH config, excluding wildcards
    if test -f ~/.ssh/config
        grep '^Host\>' ~/.ssh/config | sed 's/^Host //' | grep -v '\*'
    end
end

# If you're using the 'oil' alias, add completion for it too
complete -c oil --no-files -A -a '(__oil_ssh_get_hosts)/' -d 'SSH host'
