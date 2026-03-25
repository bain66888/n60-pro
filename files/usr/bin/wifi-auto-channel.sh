#!/bin/sh

iwinfo wlan0 scan > /tmp/2g.txt
iwinfo wlan1 scan > /tmp/5g.txt

c1=$(grep -c "Channel: 1" /tmp/2g.txt)
c6=$(grep -c "Channel: 6" /tmp/2g.txt)
c11=$(grep -c "Channel: 11" /tmp/2g.txt)

best=1; min=$c1
[ $c6 -lt $min ] && best=6 && min=$c6
[ $c11 -lt $min ] && best=11
uci set wireless.radio0.channel=$best

c36=$(grep -c "Channel: 36" /tmp/5g.txt)
c40=$(grep -c "Channel: 40" /tmp/5g.txt)
c44=$(grep -c "Channel: 44" /tmp/5g.txt)
c48=$(grep -c "Channel: 48" /tmp/5g.txt)

best=36; min=$c36
[ $c40 -lt $min ] && best=40 && min=$c40
[ $c44 -lt $min ] && best=44 && min=$c44
[ $c48 -lt $min ] && best=48

uci set wireless.radio1.channel=$best

uci commit wireless
wifi reload
