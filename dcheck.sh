#!/bin/bash

# USAGE
# $ cd /c/www/bash/domain-availability-checker
# $ LANG=C LC_ALL=C ./dcheck.sh
# $ cd /c/www/bash/domain-availability-checker && time ./dcheck.sh

# TEST
# $ cd /c/www/bash/domain-availability-checker
# $ time LANG=C LC_ALL=C echo files/test.txt | grep -Foaq '^.*(Creation Date).*$'

# CONSOLE MATCH
# $ LANG=hu_HU whois -h whois.nic.hu -H domain.hu | grep -oPa '.*(record created|No match).*'

# jwhois.conf
# https://github.com/jonasob/jwhois/blob/master/example/jwhois.conf
# whois.conf
# https://github.com/rfc1036/whois
# https://gist.github.com/thde/3890aa48e03a2b551374

TLD='.com'
#TLD='.hu'

while read -r domain; do
  #MATCH=$(jwhois --force-lookup --disable-cache --no-redirect -c jwhois.conf "$domain$TLD" | grep -oPa '^.*\b(Updated Date|Creation Date|Expiration Date)\b.*\$')
  #MATCH=$(whois -H "$domain.com" | grep -oPa '^.*(Updated Date|Creation Date|Expiration Date).*$')
  #
  #whois -H $domain'.com' | grep -oPaq '^.*(Updated Date|Creation Date|Expiration Date).*$'
  #whois -H $domain'.com' | grep -oPaq '.*Creation Date.*'
  #whois -H $domain'.com' | grep -oPaq '.*Creation Date.'
  #
  #whois -H $domain$TLD | grep -oPaq '.*Creation Date.*'
  #whois -H $domain$TLD | grep -oPaq '.*Creation Date.*'
  #
  #if [ $TLD = '.hu' ]; then
  #  whois -H $domain$TLD | grep -oPaq '.*record created.*'
  #else
  #  whois -H $domain$TLD | grep -oPaq '.*Creation Date.*'
  #fi
  #
  whois -H $domain$TLD | grep -oPaq '^.*(Creation Date|record created).*$'
  if [ $? -eq 0 ]; then
    #echo $domain'.com' | tee --append files/registered.txt && echo '   registered'
    echo $domain$TLD | tee --append 'files/registered.txt'
    #echo "" |& tee --append remove/registered.txt
    #echo -e "$domain$TLD\tregistered\t$MATCH" | tr '\n' '\t' |& tee --append files/registered.txt
  else
    #echo $domain'.com' | tee --append files/available.txt && echo '    available'
    echo $domain$TLD | tee --append 'files/available.txt'
  fi
done < 'files/domains.txt'
