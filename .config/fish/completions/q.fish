# q command completions for fish shell

# Common DNS record types
set -l dns_types A AAAA NS MX TXT CNAME PTR SOA SRV CAA DNSKEY DS NSEC NSEC3 RRSIG HTTPS

# Output formats
set -l formats pretty column json yaml raw

# TLS versions
set -l tls_versions "1.0" "1.1" "1.2" "1.3"

# HTTP methods
set -l http_methods GET POST

# Main command
complete -c q -f

# Basic options
complete -c q -s q -l qname -d 'Query name' -r
complete -c q -s s -l server -d 'DNS server(s)' -r
complete -c q -s t -l type -d 'RR type' -xa "$dns_types"
complete -c q -s x -l reverse -d 'Reverse lookup'
complete -c q -s d -l dnssec -d 'Set DNSSEC OK bit'
complete -c q -s n -l nsid -d 'Set EDNS0 NSID opt'
complete -c q -s N -l nsid-only -d 'Query only for NSID'
complete -c q -l subnet -d 'Set EDNS0 client subnet' -r
complete -c q -s c -l chaos -d 'Use CHAOS query class'
complete -c q -s C -d 'Set query class' -r
complete -c q -s p -l odoh-proxy -d 'ODoH proxy' -r

# Format options
complete -c q -s f -l format -d 'Output format' -xa "$formats"
complete -c q -l pretty-ttls -d 'Format TTLs in human readable format'
complete -c q -l short-ttls -d 'Remove zero components of pretty TTLs'
complete -c q -l color -d 'Enable color output'

# Section display options
complete -c q -l question -d 'Show question section'
complete -c q -l opt -d 'Show OPT records'
complete -c q -l answer -d 'Show answer section'
complete -c q -l authority -d 'Show authority section'
complete -c q -l additional -d 'Show additional section'
complete -c q -s S -l stats -d 'Show time statistics'
complete -c q -l all -d 'Show all sections and statistics'

# Resolution options
complete -c q -s w -d 'Resolve ASN/ASName for A/AAAA records'
complete -c q -s r -l short -d 'Show record values only'
complete -c q -s R -l resolve-ips -d 'Resolve PTR for IP addresses'
complete -c q -l round-ttls -d 'Round TTLs to nearest minute'

# Query flag options
complete -c q -l aa -d 'Set AA flag'
complete -c q -l ad -d 'Set AD flag'
complete -c q -l cd -d 'Set CD flag'
complete -c q -l rd -d 'Set RD flag'
complete -c q -l ra -d 'Set RA flag'
complete -c q -l z -d 'Set Z flag'
complete -c q -l t -d 'Set TC flag'

# TLS options
complete -c q -s i -l tls-insecure-skip-verify -d 'Disable TLS certificate verification'
complete -c q -l tls-server-name -d 'TLS server name' -r
complete -c q -l tls-min-version -d 'Minimum TLS version' -xa "$tls_versions"
complete -c q -l tls-max-version -d 'Maximum TLS version' -xa "$tls_versions"
complete -c q -l tls-next-protos -d 'TLS next protocols for ALPN' -r
complete -c q -l tls-cipher-suites -d 'TLS cipher suites' -r
complete -c q -l tls-curve-preferences -d 'TLS curve preferences' -r
complete -c q -l tls-client-cert -d 'TLS client certificate file' -r
complete -c q -l tls-client-key -d 'TLS client key file' -r
complete -c q -l tls-key-log-file -d 'TLS key log file' -r

# HTTP options
complete -c q -l http-user-agent -d 'HTTP user agent' -r
complete -c q -l http-method -d 'HTTP method' -xa "$http_methods"
complete -c q -l http2 -d 'Use HTTP/2 for DoH'
complete -c q -l http3 -d 'Use HTTP/3 for DoH'

# DNSCrypt options
complete -c q -l dnscrypt-tcp -d 'Use TCP for DNSCrypt'
complete -c q -l dnscrypt-udp-size -d 'Maximum DNS response size' -r
complete -c q -l dnscrypt-key -d 'DNSCrypt public key' -r
complete -c q -l dnscrypt-provider -d 'DNSCrypt provider name' -r

# Other options
complete -c q -l timeout -d 'Query timeout' -r
complete -c q -l pad -d 'Set EDNS0 padding'
complete -c q -l id-check -d 'Check DNS response ID'
complete -c q -l reuse-conn -d 'Reuse connections'
complete -c q -l txtconcat -d 'Concatenate TXT responses'
complete -c q -l qid -d 'Set query ID' -r
complete -c q -s b -l bootstrap-server -d 'Bootstrap DNS server' -r
complete -c q -l bootstrap-timeout -d 'Bootstrap timeout' -r
complete -c q -l cookie -d 'EDNS0 cookie' -r
complete -c q -l recaxfr -d 'Perform recursive AXFR'
complete -c q -l udp-buffer -d 'Set EDNS0 UDP size' -r

# Verbose and help options
complete -c q -s v -l verbose -d 'Show verbose messages'
complete -c q -l trace -d 'Show trace messages'
complete -c q -s V -l version -d 'Show version'
complete -c q -s h -l help -d 'Show help message'
