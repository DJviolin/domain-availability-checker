#!/usr/bin/env bash

# crunch 2 2 abcdefghijklmnopqrstuvwxyz0123456789 -o output/START -c 1000000 # 1 million line limit
# crunch 5 5 abcdefghijklmnopqrstuvwxyz0123456789 -o output/0AALL/START -c 500000 # 500.000 line limit
# crunch 5 5 abcdefghijklmnopqrstuvwxyz0123456789 -o output/0AALL/START -b 20mib
crunch 5 5 abcdefghijklmnopqrstuvwxyz0123456789 -o output/0AALL/START -c 1048576 # Excel line limit