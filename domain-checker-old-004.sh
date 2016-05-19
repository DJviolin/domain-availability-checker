#!/bin/bash

# USAGE
# cd ~/sf_bash/domain-availability-checker && ./domain-checker.sh files/input.txt

# jwhois.conf
# https://github.com/jonasob/jwhois/blob/master/example/jwhois.conf

#cat /home/debuser/share/files/input-cache.txt > /home/debuser/share/files/input.txt
#cat files/input.txt > files/input-cache.txt

# .com regex
# Transferred Date|Updated Date|Creation Date|Registration Date|Expiration Date|REGISTRAR HOLD|REGISTRY HOLD|REDEMPTION GRACE PERIOD|REDEMPTIONPERIOD

#DOMAINS='.com' # simple, space-separated list of domain suffixes
# SLOW: .xyz
# No newline: .rocks
DOMAINS='.com .co .cm .net .info .biz .org .club .work .rocks .top'

while read input; do
  for d in $DOMAINS; do
    MATCH=$(jwhois --force-lookup --disable-cache --no-redirect -c jwhois.conf "$input$d" | grep -oPa '^.*\b(Transferred Date|Updated Date|Creation Date|Registration Date|Expiration Date|Expiry Date)\b.*$')
    if [ $? -eq 0 ]; then
      #echo "" |& tee --append files/registered.txt
      echo -e "$input$d\tregistered\t"$(date +%y/%m/%d_%H:%M:%S)"\t$MATCH" | tr '\n' '\t' |& tee --append files/registered.txt
      echo "" |& tee --append files/registered.txt
    else
      echo -e "$input$d" |& tee --append files/available.txt
    fi
    #sed -i "/$input/d" files/input.txt
  done
done < "$1"
