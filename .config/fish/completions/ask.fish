function __ask_get_presets
    set -l __ask_config_file ~/.config/shell-ask/config.toml

    if test -f $__ask_config_file
        if type -q rg
            rg 'name\s*=\s*"([^"]+)"' -or '$1' $__ask_config_file
        else
            awk -F'"' '/name\s*=\s*"/ {print $2}' $__ask_config_file
        end
    end
end

complete -c ask -f

# 选项补全
complete -c ask -l cm -d "generate commit message from pipeline" -x
complete -c ask -s c -l command -d "in terminal mode" -x
complete -c ask -s m -l model -d "specify model" -xa "$(cat ~/.config/shell-ask/models)"
complete -c ask -s p -l preset-name -d "specify preset from config file" -xa "(__ask_get_presets)"
complete -c ask -l ps -d "show preset info from config file" -x
complete -c ask -s s -l system -d "use system prompt" -x
complete -c ask -s h -l help -d "Print help" -x
complete -c ask -s V -l version -d "Print version" -x
