#!/bin/bash

while read domain; do

  printf '%s ' "$domain" # This way we know what whois is currently looking up before it completes.
  jwhois "$domain" | egrep -qci 'No Match'
  if
    [ $? -ne 0 ]; then echo "REGISTERED"; else echo "AVAILABLE";
  fi

done
