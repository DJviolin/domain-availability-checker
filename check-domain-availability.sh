#!/bin/bash

# Name: Check for domain name availability
# linuxconfig.org
# Please copy, share, redistribute and improve

# http://linuxconfig.org/check-domain-name-availability-with-bash-and-whois
# USAGE
# $ cd /c/www/html/domain-check/bash
# Make script executable:
# $ chmod +x check-domain-availability.sh
# Execute script:
# $ ./check-domain-availability.sh foo1 foo2

# WINDOWS: $ whois com. whois.iana.org
# LINUX: $ whois -h whois.iana.org com
# BASIC USAGE: whois domain.com

if [ "$#" == "0" ]; then
    echo "You need tu supply at least one argument!"
    exit 1
fi

DOMAINS=( '.com' '.hu' \
'.net' '.info' '.org' '.biz' '.mobi' \
'.eu' '.ru' '.co.uk' '.com.au' \
'.tel' '.tv' '.cc' \
'.in' '.it' '.sk' )

ELEMENTS=${#DOMAINS[@]}

while (( "$#" )); do

  for (( i=0;i<$ELEMENTS;i++)); do
      whois $1${DOMAINS[${i}]} | egrep -q \
      '^No match|^NOT FOUND|^Not fo|AVAILABLE|^No Data Fou|has not been regi|No entri'
    if [ $? -eq 0 ]; then
        echo "$1${DOMAINS[${i}]} : available"
    fi
  done

shift

done
