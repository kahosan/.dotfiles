function logg --description "tail grep bat"
    if test -z $argv[1];
        echo "Usage: logg <file> [pattern]"
        return
    end

    test -z $argv[2] && tail -f $argv[1] | bat --paging=never -pllog

    tail -f $argv[1] | grep --line-buffered $argv[2] | bat --paging=never -pllog
end
