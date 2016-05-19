 #!/bin/bash

 # USAGE
# cd ~/sf_bash/domain-availability-checker && ./domain-checker-alone.sh DOMAIN

# Name: Check for domain name availability
# linuxconfig.org
# Please copy, share, redistribute and improve

if [ "$#" == "0" ]; then
    echo "You need tu supply at least one argument!"
    exit 1
fi

DOMAINS=( \
'.com' '.co' '.club' '.rocks' '.us' '.biz' '.news' '.info' '.net' '.org' '.me' '.co.uk' '.mobi' '.ninja' '.de' '.ca' '.tv' '.es' '.in' '.nyc' \
'.cc' '.ws' '.hu' '.com.au' '.global' '.company' '.life' '.guru' '.photography' '.today' '.solutions' '.media' '.world' '.sex' '.xxx' '.tel' '.cc' '.ru' '.it' '.sk' \
'.tel' '.cc' '.ru' \
'.it' '.sk' '.com.au'
#'.xyz' '.online' '.tech' '.site' '.design' '.io' '.press' '.space' '.website' '.pw' '.eu' '.link' '.space' \
 )

ELEMENTS=${#DOMAINS[@]}

while (( "$#" )); do
  for (( i=0;i<$ELEMENTS;i++)); do
      jwhois --force-lookup --disable-cache --no-redirect -c jwhois.conf "$1${DOMAINS[${i}]}" | grep -oPaq '^.*\b(Transferred Date|Updated Date|Creation Date|Registration Date|Expiration Date|Expiry Date)\b.*$'
    if [ $? -eq 0 ]; then
      echo "$1${DOMAINS[${i}]} : registered"
    else
      echo "$1${DOMAINS[${i}]} : available"
    fi
  done
shift
done
