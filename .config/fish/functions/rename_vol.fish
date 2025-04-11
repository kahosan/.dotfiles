function rename_vol --description "rename epub file volumes"
    if test (count $argv) -lt 1
        echo "用法: $argv0 <基本文件名>"
        exit 1
    end

    set base_name $argv[1]

    function arabic_to_chinese
        set -l n (math "$argv[1]")
        if test $n -le 10
            switch $n
                case 1; echo "一"; return
                case 2; echo "二"; return
                case 3; echo "三"; return
                case 4; echo "四"; return
                case 5; echo "五"; return
                case 6; echo "六"; return
                case 7; echo "七"; return
                case 8; echo "八"; return
                case 9; echo "九"; return
                case 10; echo "十"; return
            end
        else if test $n -lt 20
            # 11–19: 十一、十二…
            set unit (math "$n - 10")
            echo -n "十"
            if test $unit -ne 0
                echo -n (arabic_to_chinese $unit)
            end
            return
        else
            # 20–99: 二十、二十一…九十九
            set tens (math "floor($n / 10)")
            set unit (math "$n % 10")
            set tens_cn (arabic_to_chinese $tens)
            echo -n "$tens_cn""十"
            if test $unit -ne 0
                echo -n (arabic_to_chinese $unit)
            end
            return
        end
    end
    for file in *.epub
        if string match -qr '0[0-9]|\d{1,3}' $file
            set num (string match -r '0[0-9]|\d{1,3}' $file)
        else
            continue
        end

        set num (string trim --left -c '0' -- $num)
        if test -z "$num"
            set num 0
        end

        set cn (arabic_to_chinese $num)

        set newname {$base_name} 第{$cn}卷.epub

        echo "重命名: '$file' → '$newname'"

        if test "$argv[2]" = "y"
            mv "$file" "$newname"
        end
    end
end
