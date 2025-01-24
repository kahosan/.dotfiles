function __ask_get_presets
    if test -f ~/.config/shell-ask/config.toml
        if type -q rg
            rg 'name\s*=\s*"([^"]+)"' -or '$1' ~/.config/shell-ask/config.toml
        else
            awk -F'"' '/name\s*=\s*"/ {print $2}' ~/.config/shell-ask/config.toml
        end
    end
end

set -l __ask_models \
    gpt-4o \
    gpt-4o-mini \
    claude-3-5-sonnet-20241022 \
    qwen2.5-72b-inst \
    deepseek-r1-llama3.3-70b \
    qwen2-vl-72b

complete -c ask -f

# 选项补全
complete -c ask -l cm -d "generate commit message from pipeline" -x
complete -c ask -s c -l command -d "in terminal mode" -x
complete -c ask -s m -l model -d "specify model" -xa "$__ask_models"
complete -c ask -s p -l preset-name -d "specify preset from config file" -xa "(__ask_get_presets)"
complete -c ask -l ps -d "show preset info from config file" -x
complete -c ask -s s -l system -d "use system prompt" -x
complete -c ask -s h -l help -d "Print help" -x
complete -c ask -s V -l version -d "Print version" -x
