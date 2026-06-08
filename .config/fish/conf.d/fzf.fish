function fzf-history -d "Show command history"
    test -z "$fish_private_mode"; and builtin history merge

    if set -l result (
        builtin history -z | fzf \
            --read0 --print0 \
            --layout=reverse \
            --height=60% \
            --no-info \
            --no-separator \
            --prompt='(reverse-i-search): ' \
            --ghost='Type to search..' \
            --scheme=history \
            --bind=ctrl-r:toggle-sort \
            --bind=ctrl-e:ignore \
            --bind=ctrl-p:ignore \
            --gutter=' ' \
            --color=bg:-1,bg+:-1,fg:-1,fg+:-1,hl:-1,hl+:-1,prompt:-1,pointer:8,info:-1,border:-1,gutter:-1 \
            --color=fg+:regular,hl:regular,hl+:regular,prompt:regular,query:regular \
            --query=(commandline) \
        | string split0
    )
        commandline -- $result
    end
    commandline -f repaint
end

set -gx FZF_DEFAULT_OPTS "
    --read0 --print0 \
    --layout=reverse \
    --height=60% \
    --no-info \
    --no-separator \
    --prompt='(search): ' \
    --ghost='Type to search..' \
    --gutter=' ' \
    --color=bg:-1,bg+:-1,fg:-1,fg+:-1,hl:-1,hl+:-1,prompt:-1,pointer:8,info:-1,border:-1,gutter:-1 \
    --color=fg+:regular,hl:regular,hl+:regular,prompt:regular,query:regular \
    --bind='ctrl-e:become(nvim {})'
    --bind='ctrl-p:execute(less {})'
"

if type -q fzf
    bind \cr fzf-history
    bind -M insert \cr fzf-history
end
