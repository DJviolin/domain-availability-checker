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

#TLD='.com'

while read -r domain; do
  #MATCH=$(jwhois --force-lookup --disable-cache --no-redirect -c jwhois.conf "$domain$TLD" | grep -oPa '^.*\b(Updated Date|Creation Date|Expiration Date)\b.*\$')
  #MATCH=$(whois -H "$domain$TLD" | grep -oPa '^.*\b(Updated Date|Creation Date|Expiration Date)\b.*\$')
  #whois -H "$domain$TLD" | grep -oPa '^.*\b(Updated Date|Creation Date|Expiration Date)\b.*\$'
  #whois -H "$domain$TLD" | grep -oPa '^.*(Updated Date|Creation Date|Expiration Date).*$'
  whois -H "$domain.com" | grep -oPa '^.*(Updated Date|Creation Date|Expiration Date).*$'
  if [ $? -eq 0 ]; then
    #echo -e "$domain$TLD" |& tee --append files/registered.txt
    #echo "$domain$TLD" | tee --append files/registered.txt && echo "   registered"
    echo "$domain.com" | tee --append files/registered.txt && echo "   registered"
    #
    #echo "" |& tee --append remove/registered.txt
    #echo -e "$domain$TLD\tregistered\t$MATCH" | tr '\n' '\t' |& tee --append files/registered.txt
  else
    #echo "$domain$TLD" |& tee --append files/available.txt
    #echo "$domain$TLD" | tee --append files/available.txt && echo "    available"
    echo "$domain.com" | tee --append files/available.txt && echo "    available"
  fi
done < files/domains.txt
