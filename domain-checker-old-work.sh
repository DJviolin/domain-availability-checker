#!/bin/bash

# USAGE
# cd ~/sf_bash/domain-availability-checker && ./domain-checker-old-work.sh remove/input.txt

# jwhois.conf
# https://github.com/jonasob/jwhois/blob/master/example/jwhois.conf

DOMAINS=( \
'.com' \
#'.net' \
#'.biz' \
)

while read input; do
  for (( i=0;i<${#DOMAINS[@]};i++)); do
  MATCH=$(jwhois --force-lookup --disable-cache --no-redirect -c jwhois.conf "$input${DOMAINS[$i]}" | grep -oPa '^.*\b(Transferred Date|Updated Date|Creation Date|Registration Date|Expiration Date|REGISTRAR HOLD|REGISTRY HOLD|REDEMPTION GRACE PERIOD|REDEMPTIONPERIOD)\b.*$')
  if [ $? -eq 0 ]; then
    echo -e "$input${DOMAINS[$i]}\tregistered\t"$(date +%y/%m/%d_%H:%M:%S)"\t$MATCH" | tr '\n' '\t' |& tee --append remove/registered.txt
    echo "" |& tee --append remove/registered.txt
  else
    echo -e "$input${DOMAINS[$i]}\tavailable\t"$(date +%y/%m/%d_%H:%M:%S)"\t$MATCH" | tr '\n' '\t' |& tee --append remove/available.txt
    echo "" |& tee --append remove/available.txt
  fi
  done
done < "$1"
