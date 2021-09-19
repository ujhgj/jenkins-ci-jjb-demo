. /etc/os-release
cat << EOF
Host name: $(hostname)
OS version: $PRETTY_NAME
CPU cores: $(grep -c processor /proc/cpuinfo)
RAM: $(cat /proc/meminfo | grep 'MemTotal:' | awk '{ print $2 $3 }')
HDD size: $(df -h | grep '/$' | awk '{ print $2 }')
HDD disk usage: $(df -h | grep '/$' | awk '{ print $3 }')
EOF
