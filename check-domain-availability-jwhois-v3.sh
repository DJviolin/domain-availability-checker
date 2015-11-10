#!/bin/bash

while read domain; do

  printf '%s ' "$domain" # This way we know what whois currently looking up before it completes.
  jwhois "$domain" | egrep -q 'No Match'
  if [ $? -eq 0 ]; then
      echo "REGISTERED"; else
      echo "AVAILABLE";
  fi

done
