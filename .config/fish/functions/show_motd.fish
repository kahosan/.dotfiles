function show_motd --description "show motd info"
    if test -f /run/motd.dynamic
        cat /run/motd.dynamic
    else if test -f /etc/motd
        cat /etc/motd
    else
        echo "no motd information available" >&2
        return 1
    end
end

