function nali-mtr --description "mtr"
  sudo mtr -b -z -a (ifconfig | awk '/inet /&&!/127.0.0.1/{print $2;exit}') $argv | nali
end
