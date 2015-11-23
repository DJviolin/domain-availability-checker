#!/bin/bash

# USAGE
# cd ~/sf_bash/domain-availability-checker && ./domain-checker.sh files/input.txt

# jwhois.conf
# https://github.com/jonasob/jwhois/blob/master/example/jwhois.conf

cat files/input-cache.txt > files/input.txt
cat files/input.txt > files/input-cache.txt

DOMAINS='.com' # simple, space-separated list of domain suffixes

while read -r input; do
  for d in $DOMAINS; do
    MATCH=$(jwhois --force-lookup --disable-cache --no-redirect -c jwhois.conf "$input$d" | grep -oPa '^.*\b(Transferred Date|Updated Date|Creation Date|Registration Date|Expiration Date|REGISTRAR HOLD|REGISTRY HOLD|REDEMPTION GRACE PERIOD|REDEMPTIONPERIOD)\b.*$')
    if [ $? -eq 0 ]; then
      echo "" |& tee --append files/registered.txt
      echo -e "$input$d\tregistered\t"$(date +%y/%m/%d_%H:%M:%S)"\t$MATCH" | tr '\n' '\t' |& tee --append files/registered.txt
      #echo "" |& tee --append files/registered.txt
    else
      echo "" |& tee --append files/available.txt
      echo -e "$input$d\tavailable\t"$(date +%y/%m/%d_%H:%M:%S)"\t$MATCH" | tr '\n' '\t' |& tee --append files/available.txt
      #echo "" |& tee --append files/available.txt
    fi
  done
  sed -i "/$input/d" files/input-cache.txt
done < "$1"
