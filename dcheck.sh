#!/bin/bash

# USAGE
# cd /c/www/bash/domain-availability-checker && ./dcheck.sh

# jwhois.conf
# https://github.com/jonasob/jwhois/blob/master/example/jwhois.conf
# whois.conf
# https://github.com/rfc1036/whois
# https://gist.github.com/thde/3890aa48e03a2b551374

# .com regex
# Transferred Date|Updated Date|Creation Date|Registration Date|Expiration Date|REGISTRAR HOLD|REGISTRY HOLD|REDEMPTION GRACE PERIOD|REDEMPTIONPERIOD

TLD='.com'

while read -r domain; do
  #MATCH=$(jwhois --force-lookup --disable-cache --no-redirect -c jwhois.conf "$domain$TLD" | grep -oPa '^.*\b(Updated Date|Creation Date|Expiration Date)\b.*\$')
  MATCH=$(whois -H "$domain$TLD" | grep -oPa '^.*\b(Updated Date|Creation Date|Expiration Date)\b.*\$')
  if [ $? -eq 0 ]; then
    #echo -e "$domain$TLD" |& tee --append files/registered.txt
    echo "$domain$TLD" | tee --append files/registered.txt && echo "   registered"
  else
    #echo "$domain$TLD" |& tee --append files/available.txt
    echo "$domain$TLD" | tee --append files/available.txt && echo "    available"
  fi
#done < $DOMAINS
done < files/domains.txt
