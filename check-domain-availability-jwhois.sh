#!/bin/bash

# Name: Check for domain name availability
# linuxconfig.org
# Please copy, share, redistribute and improve

# USAGE
# Make script executable:
# $ chmod +x check-domain-availability-jwhois.sh
# Execute script:
# $ ./check-domain-availability-jwhois.sh foo1 foo2

# WINDOWS: $ jwhois com. whois.iana.org
# LINUX: $ jwhois -h whois.iana.org com
# BASIC USAGE: jwhois domain.com

if [ "$#" == "0" ]; then
    echo "You need tu supply at least one argument!"
    exit 1
fi

### GoDaddy TLDS: https://www.godaddy.com/tlds/gtld.aspx - Only checked: .global
DOMAINS=( \
'.com' \
#'.hu' \
#'.net' '.info' '.org' '.biz' '.mobi' \
#'.eu' '.ru' '.co.uk' '.com.au' \
#'.online' '.xyz' '.global' '.site' '.tech' '.space' '.news' '.club' '.rocks' '.design' '.company' '.life' '.website' \
#'.tel' '.tv' '.cc' \
#'.in' '.it' '.sk' \
)

ELEMENTS=${#DOMAINS[@]}

while (( "$#" )); do

  for (( i=0;i<$ELEMENTS;i++)); do
      jwhois $1${DOMAINS[${i}]} | egrep -q \
      '^No match|^NOT FOUND|^Not fo|AVAILABLE|^No Data Fou|has not been regi|No entri'
    if [ $? -eq 0 ]; then
        echo "$1${DOMAINS[${i}]} : available" else
        echo "$1${DOMAINS[${i}]} : registered / not found"
    fi
  done

shift

done
