#!/usr/bin/env bash

# USAGE
# sed -i 's/\r//g' script.sh
# ./check-domain-availability-jwhois-new.sh input.txt

#grep -oPaq 'clientTransferProhibited|CLIENT TRANSFER PROHIBITED|clientUpdateProhibited|CLIENT UPDATE PROHIBITED|clientRenewProhibited|CLIENT RENEW PROHIBITED|clientDeleteProhibited|CLIENT DELETE PROHIBITED|Registry Domain ID|Creation Date|Registrar WHOIS Server|Registrar URL|Registrar IANA ID|record created|\% This query returned 1 object|Created On|Registry Reserved Name|Registrant Contact Name|Fax|Registered on'

DOMAINS=( '.com' \
#'.biz' \
#'.me' '.org' '.net' '.info' '.cc' '.ws' '.hu' '.co' '.eu' '.mobi' '.co.uk' '.com.au' '.online' '.xyz' '.global' '.site' '.tech' '.space' '.news' '.club' '.rocks' '.design' '.company' '.life' '.website' '.nyc' '.guru' '.photography' '.today' '.solutions' '.media' '.world' '.sex' '.xxx' '.tel' '.tv' '.cc' '.ru' '.in' '.it' '.sk' \
)

while read input; do
  for (( i=0;i<${#DOMAINS[@]};i++)); do
  MATCH=$(jwhois --force-lookup --disable-cache --no-redirect -c jwhois.conf "$input${DOMAINS[$i]}" | grep -oPa '^.*\b(clientTransferProhibited)\b.*$')
  if [ $? -eq 0 ]; then
    echo -e "$input${DOMAINS[$i]}\tregistered\t" $(date +%y/%m/%d_%H:%M:%S) "\t" "$MATCH" |& tee --append output/registered.txt
  else
    echo -e "$input${DOMAINS[$i]}\tavailable\t" $(date +%y/%m/%d_%H:%M:%S) "\t" "$MATCH" |& tee --append output/available.txt
  fi
  done
done < "$1"
