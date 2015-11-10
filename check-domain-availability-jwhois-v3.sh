#!/bin/bash
# Based off of https://superuser.com/questions/433316/check-a-list-of-domains-with-the-whois-command
while read domain; do
  printf '%s ' "$domain" # This way we know what whois is currently looking up before it completes.
  jwhois "$domain" | grep -qci 'No Match'
  if [ $? -ne 0 ]; then echo "REGISTERED"; else echo "AVAILABLE"; fi
done
