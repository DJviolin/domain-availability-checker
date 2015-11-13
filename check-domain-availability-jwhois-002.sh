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
# jwhois -c jwhois.conf domain.com

# Configuration File (2015-09-12):
# https://github.com/robert-scheck/jwhois/blob/master/example/jwhois.conf

# BLACKLISTED:
# [whois.ausregistry.net.au]
# TLD not having WHOIs server:
# '.fm' -> http://dot.fm/whois.html

# Original regex:
#'^No match|^NOT FOUND|^Not fo|AVAILABLE|^No Data Fou|has not been regi|No entri'

# REGEX problems:
# '.net'

# FULL REGEXP:
# 'clientTransferProhibited|CLIENT TRANSFER PROHIBITED|clientUpdateProhibited|CLIENT UPDATE PROHIBITED|clientRenewProhibited|CLIENT RENEW PROHIBITED|clientDeleteProhibited|CLIENT DELETE PROHIBITED|Registry Domain ID|Creation Date|Registrar WHOIS Server|Registrar URL|Registrar IANA ID|record created|\% This query returned 1 object|Created On|Expiration Date|Registry Reserved Name|Registrant Contact Name|Fax|Registered on'

ECHODATE=(`date +%y/%m/%d_%H:%M:%S`)

if [ "$#" == "0" ]; then
    echo "You need tu supply at least one argument!"
    exit 1
fi

### GoDaddy TLDS: https://www.godaddy.com/tlds/gtld.aspx - Only checked: .global
DOMAINS=( \
'.com' \
#'.biz' \
#'.me' \
#'.org' \
#'.net' \
#'.info' \
#'.cc' \
#'.ws' \
# \
'.hu' \
#'.co' '.eu' '.mobi' '.co.uk' '.com.au' \
#'.online' '.xyz' '.global' '.site' '.tech' '.space' '.news' '.club' '.rocks' '.design' '.company' '.life' '.website' '.nyc' '.guru' '.photography' '.today' '.solutions' '.media' '.world' \
#'.sex' '.xxx' \
#'.tel' '.tv' '.cc' \
# Need citizenship \
#'.ru' \
#'.in' '.it' '.sk' \
)

ELEMENTS=${#DOMAINS[@]}

while (( "$#" )); do

  for (( i=0;i<$ELEMENTS;i++)); do
      jwhois --force-lookup --disable-cache -c jwhois.conf $1${DOMAINS[${i}]} | grep --perl-regexp --text --null --only-matching --quiet \
      'clientTransferProhibited|CLIENT TRANSFER PROHIBITED|clientUpdateProhibited|CLIENT UPDATE PROHIBITED|clientRenewProhibited|CLIENT RENEW PROHIBITED|clientDeleteProhibited|CLIENT DELETE PROHIBITED|Registry Domain ID|Creation Date|Registrar WHOIS Server|Registrar URL|Registrar IANA ID|record created|\% This query returned 1 object|Created On|Registry Reserved Name|Registrant Contact Name|Fax|Registered on'
    if [ $? -eq 0 ]; then
        echo -e "$1${DOMAINS[${i}]}\tregistered\t"$ECHODATE |& tee --append output/registered.txt
    else
        echo -e "$1${DOMAINS[${i}]}\tavailable / missing regexp\t"$ECHODATE |& tee --append output/available.txt
    fi
  done

shift

done
