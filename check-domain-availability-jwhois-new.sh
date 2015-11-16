#!/usr/bin/env bash

# USAGE
# sed -i 's/\r//g' script.sh
# ./check-domain-availability-jwhois-new.sh input.txt

# Matching entire line
# http://www.regular-expressions.info/completelines.html
# ^.*\b(clientTransferProhibited|CLIENT TRANSFER PROHIBITED|Registry Domain ID)\b.*$
# http://stackoverflow.com/questions/7103531/how-to-get-the-part-of-file-after-the-line-that-matches-grep-expression-first
# http://stackoverflow.com/questions/5385234/using-sed-awk-to-print-lines-with-matching-pattern-or-another-matching-pattern

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

#ECHODATE=(`date +%y/%m/%d_%H:%M:%S`)

#MATCH1=(`sed -n -e '1,/Domain Name/,$p'`)
#MATCH1_ECHO=echo "$MATCH1"

while read input; do
  for (( i=0;i<${#DOMAINS[@]};i++)); do
  jwhois --force-lookup --disable-cache --no-redirect -c jwhois.conf "$input${DOMAINS[$i]}" | grep -oPaq 'clientTransferProhibited|CLIENT TRANSFER PROHIBITED|clientUpdateProhibited|CLIENT UPDATE PROHIBITED|clientRenewProhibited|CLIENT RENEW PROHIBITED|clientDeleteProhibited|CLIENT DELETE PROHIBITED|Registry Domain ID|Creation Date|Registrar WHOIS Server|Registrar URL|Registrar IANA ID|record created|\% This query returned 1 object|Created On|Registry Reserved Name|Registrant Contact Name|Fax|Registered on'
  if [ $? -eq 0 ]; then
    echo -e "$input${DOMAINS[$i]}\tregistered\t"`date +%y/%m/%d_%H:%M:%S`"\t" |& tee --append output/registered.txt
  else
    echo -e "$input${DOMAINS[$i]}\tavailable\t"`date +%y/%m/%d_%H:%M:%S`"\t" |& tee --append output/available.txt
  fi
  done
done < "$1"
