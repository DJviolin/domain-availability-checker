#!/bin/bash

# Check the list of domains domains.txt, and add the domain to available.txt
# once it's found (by looking at the return value of grep, which is stored in $?).
# Then, remove the found domains from domains.txt with sed in-place editing.

AVAILABLE=~/available.txt
DOMAINS=~/domains.txt

lockfile whois-script.lock

while read -r domain; do
  jwhois $domain | grep -qci "No match"
  if [ $? -ne 0 ]; then
    # found
    echo $domain >> $AVAILABLE
  fi
done < $DOMAINS

while read -r domain; do
  sed -i "/$domain/d" $DOMAINS
done < $AVAILABLE

rm -f whois-script.lock
