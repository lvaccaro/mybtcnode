-------
/etc/wireguard/wg0.conf 

[Interface]
PrivateKey = 
Address = 10.8.0.2/24

[Peer]
PublicKey = k9x9E8kogniGYBRLpvM+XUSU1OorRkH7c3uvDAc9/Qw=
AllowedIPs = 0.0.0.0/0
Endpoint = ${GATEWAY}:51820
-------

sudo wg-quick up wg0
sudo wg show
ping 10.8.0.1