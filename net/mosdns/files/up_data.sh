#!/bin/sh

DIR=/etc/mosdns/rule

wget 'https://cdn.jsdelivr.net/gh/Hackl0us/GeoIP2-CN@release/CN-ip-cidr.txt' -q -O $DIR/CN-ip-cidr.txt
wget 'https://cdn.jsdelivr.net/gh/Loyalsoldier/v2ray-rules-dat@release/proxy-list.txt' -q -O $DIR/proxy-list.txt
wget 'https://cdn.jsdelivr.net/gh/Loyalsoldier/v2ray-rules-dat@release/reject-list.txt' -q -O $DIR/reject-list.txt
wget 'https://cdn.jsdelivr.net/gh/Loyalsoldier/v2ray-rules-dat@release/direct-list.txt' -q -O $DIR/direct-list.txt

/etc/init.d/mosdns restart

