#!/usr/bin/env bash

# USAGE
# sed -i 's/\r//g' script.sh
# ./domain-checker.sh input.txt
# jwhois --force-lookup --disable-cache --no-redirect -c jwhois.conf "$input${DOMAINS[$i]}" | grep -oPa '^.*\b(Update Date|Creation Date|Expiration Date)\b.*$')
# jwhois --force-lookup --disable-cache -c jwhois.conf lantosistvan.com | grep -oPa '^.*\b(Update Date|Creation Date|Expiration Date)\b.*$'

# Remove line breaks
# [\r\n]+
# | tr '\n' '\t'

# jwhois.conf
# https://github.com/jonasob/jwhois/blob/master/example/jwhois.conf

#grep -oPaq 'clientTransferProhibited|CLIENT TRANSFER PROHIBITED|clientUpdateProhibited|CLIENT UPDATE PROHIBITED|clientRenewProhibited|CLIENT RENEW PROHIBITED|clientDeleteProhibited|CLIENT DELETE PROHIBITED|Registry Domain ID|Creation Date|Registrar WHOIS Server|Registrar URL|Registrar IANA ID|record created|\% This query returned 1 object|Created On|Registry Reserved Name|Registrant Contact Name|Fax|Registered on'

DOMAINS=( '.com' \
#'.biz' \
#'.me' '.org' '.net' '.info' '.cc' '.ws' '.hu' '.co' '.eu' '.mobi' '.co.uk' '.com.au' '.online' '.xyz' '.global' '.site' '.tech' '.space' '.news' '.club' '.rocks' '.design' '.company' '.life' '.website' '.nyc' '.guru' '.photography' '.today' '.solutions' '.media' '.world' '.sex' '.xxx' '.tel' '.tv' '.cc' '.ru' '.in' '.it' '.sk' \
)

while read input; do
  for (( i=0;i<${#DOMAINS[@]};i++)); do
  MATCH=$(jwhois --force-lookup --disable-cache --no-redirect -c jwhois.conf "$input${DOMAINS[$i]}" | grep -oPa '^.*\b(Transferred Date|Updated Date|Creation Date|Registration Date|Expiration Date)\b.*$')
  if [ $? -eq 0 ]; then
    echo -e "$input${DOMAINS[$i]}\tregistered\t"$(date +%y/%m/%d_%H:%M:%S)"\t$MATCH" | tr '\n' '\t' |& tee --append output/registered.txt
    echo "" |& tee --append output/registered.txt
  else
    echo -e "$input${DOMAINS[$i]}\tavailable\t"$(date +%y/%m/%d_%H:%M:%S)"\t$MATCH" | tr '\n' '\t' |& tee --append output/available.txt
    echo "" |& tee --append output/available.txt
  fi
  done
done < "$1"
