function curltime --description 'Measure connection timing breakdown for a URL'
    if test (count $argv) -eq 0
        echo "Usage: curltime <url>"
        return 1
    end

    curl -o /dev/null -s -w "\
DNS Lookup:               %{time_namelookup}s\n\
TCP Connect:              %{time_connect}s\n\
TLS Handshake:            %{time_appconnect}s\n\
Time to First Byte:       %{time_starttransfer}s\n\
Total Time:               %{time_total}s\n" \
        $argv[1]
end
