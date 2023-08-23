sudo apt-get install wireguard
sudo wg

------
/etc/wireguard/wg0.conf 
[Interface]
Address = 10.8.0.1/24
SaveConfig = true
ListenPort = 51820
PrivateKey = 

[Peer]
PublicKey = 

[Peer]
PublicKey = 
AllowedIPs = 10.8.0.2/32
------

sudo wg-quick up wg0
sudo wg show
ping 10.8.0.2

iptables -A PREROUTING -t nat -i eth0 -p tcp -m tcp --dport 9735 -j DNAT --to 10.8.0.1:9735
iptables -A PREROUTING -t nat -i eth0 -p udp -m udp --dport 9735 -j DNAT --to 10.8.0.1:9735
iptables -t nat -A POSTROUTING -d 10.8.0.0/32 -o tun0 -j MASQUERADE
