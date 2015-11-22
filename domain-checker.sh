#!/bin/bash

# USAGE
# cd ~/sf_bash/domain-availability-checker && ./domain-checker.sh remove/input.txt

# jwhois.conf
# https://github.com/jonasob/jwhois/blob/master/example/jwhois.conf

# It will only deleting the lines when the script totally finishing (not terminated)

DOMAINS='.com' # simple, space-separated list of domain suffixes

while read input; do
  for d in $DOMAINS; do
    MATCH=$(jwhois --force-lookup --disable-cache --no-redirect -c jwhois.conf "$input$d" | grep -oPa '^.*\b(Transferred Date|Updated Date|Creation Date|Registration Date|Expiration Date|REGISTRAR HOLD|REGISTRY HOLD|REDEMPTION GRACE PERIOD|REDEMPTIONPERIOD)\b.*$')

    if [ $? ] ; then regavail="registered" ; else regavail="available" ; fi

    out=$(printf '%s\t%s' "$(date +%y/%m/%d_%H:%M:%S)" "$MATCH" | tr '\n' '\t')

    printf '%s\t%s\t%s\n' "$input$d" "$regavail" "$out" |& tee --append "remove/$regavail.txt"

    seen+="$input\|"
  done
done < "$1"
seen=$(printf '%s' "$seen" | sed -e 's/\\|$//')
sed -i -e "/^\($seen\)$/d" "$1"
