#!/bin/bash

# USAGE
# cd ~/sf_bash/domain-availability-checker && ./domain-checker-old-work.sh remove/input.txt

# jwhois.conf
# https://github.com/jonasob/jwhois/blob/master/example/jwhois.conf

cat remove/input-cache.txt > remove/input.txt
cat remove/input.txt > remove/input-cache.txt

DOMAINS='.com' # simple, space-separated list of domain suffixes

while read -r input; do
  for d in $DOMAINS; do
    MATCH=$(jwhois --force-lookup --disable-cache --no-redirect -c jwhois.conf "$input$d" | grep -oPa '^.*\b(Transferred Date|Updated Date|Creation Date|Registration Date|Expiration Date|REGISTRAR HOLD|REGISTRY HOLD|REDEMPTION GRACE PERIOD|REDEMPTIONPERIOD)\b.*$')
    if [ $? -eq 0 ]; then
      echo "" |& tee --append remove/registered.txt
      echo -e "$input$d\tregistered\t"$(date +%y/%m/%d_%H:%M:%S)"\t$MATCH" | tr '\n' '\t' |& tee --append remove/registered.txt
      #echo "" |& tee --append remove/registered.txt
    else
      echo "" |& tee --append remove/available.txt
      echo -e "$input$d\tavailable\t"$(date +%y/%m/%d_%H:%M:%S)"\t$MATCH" | tr '\n' '\t' |& tee --append remove/available.txt
      #echo "" |& tee --append remove/available.txt
    fi
  done
  sed -i "/$input/d" remove/input-cache.txt
done < "$1"
