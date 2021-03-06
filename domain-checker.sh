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
# SLOW: .org .xyz
# .cc .cn .xxx .me .mobi .eu
#DOMAINS='.co .cm .net .info .biz .club .work .rocks .top'
DOMAINS='.net'

while read input; do
  for d in $DOMAINS; do
    MATCH=$(jwhois --force-lookup --disable-cache --no-redirect -c jwhois.conf "$input$d" | grep -oPa '^.*\b(Transferred Date|Updated Date|Creation Date|Registration Date|Expiration Date|Expiry Date)\b.*$')
    if [ $? -eq 0 ]; then
      echo -e "$input$d\tregistered\t" |& tee --append files/registered.txt
    else
      echo -e "$input$d" |& tee --append files/available.txt
    fi
  done
done < "$1"
