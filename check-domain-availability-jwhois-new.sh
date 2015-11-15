#!/usr/bin/env bash

# USAGE
# sed -i 's/\r//g' script.sh
# ./check-domain-availability-jwhois-new.sh input.txt

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
#'.hu' \
#'.co' '.eu' '.mobi' '.co.uk' '.com.au' \
#'.online' '.xyz' '.global' '.site' '.tech' '.space' '.news' '.club' '.rocks' '.design' '.company' '.life' '.website' '.nyc' '.guru' '.photography' '.today' '.solutions' '.media' '.world' \
#'.sex' '.xxx' \
#'.tel' '.tv' '.cc' \
# Need citizenship \
#'.ru' \
#'.in' '.it' '.sk' \
)

ECHODATE=(`date +%y/%m/%d_%H:%M:%S`)

while read input; do
  for (( i=0;i<${#DOMAINS[@]};i++)); do
  jwhois --force-lookup --disable-cache --no-redirect -c jwhois.conf "$input${DOMAINS[$i]}" | grep -oPaq \
    'clientTransferProhibited|CLIENT TRANSFER PROHIBITED|clientUpdateProhibited|CLIENT UPDATE PROHIBITED|clientRenewProhibited|CLIENT RENEW PROHIBITED|clientDeleteProhibited|CLIENT DELETE PROHIBITED|Registry Domain ID|Creation Date|Registrar WHOIS Server|Registrar URL|Registrar IANA ID|record created|\% This query returned 1 object|Created On|Registry Reserved Name|Registrant Contact Name|Fax|Registered on'
  if [ $? -eq 0 ]; then
    echo -e "$input${DOMAINS[$i]}\tregistered\t"$ECHODATE |& tee --append output/registered.txt
  else
    echo -e "$input${DOMAINS[$i]}\tavailable\t"$ECHODATE |& tee --append output/available.txt
  fi
  done
done < "$1"
