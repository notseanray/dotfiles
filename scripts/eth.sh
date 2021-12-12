ifconfig enp27s0 up
ifconfig $1 192.168.1.91 broadcast 255.255.255.0 netmask 255.255.255.0 up
route add default gw 192.168.1.254
echo 1 > /proc/sys/net/ipv6/conf/default/disable_ipv6
echo 1 > /proc/sys/net/ipv6/conf/all/disable_ipv6
echo "interface set"
ping -c 2 google.com
