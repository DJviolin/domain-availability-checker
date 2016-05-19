#!/bin/bash

# crunch 2 2 abcdefghijklmnopqrstuvwxyz0123456789 -o output/START -c 1000000 # 1 million line limit
# crunch 5 5 abcdefghijklmnopqrstuvwxyz0123456789 -o output/0AALL/START -c 500000 # 500.000 line limit
# crunch 5 5 abcdefghijklmnopqrstuvwxyz0123456789 -o output/0AALL/START -b 20mib
#crunch 5 5 abcdefghijklmnopqrstuvwxyz0123456789 -o output/0AALL/START -c 1048576 # Excel line limit
#crunch 6 6 0123456789 -o output/000000.txt -c 1048576
#crunch 3 3 abcdefghijklmnopqrstuvwxyz -o output/ALL.txt
#crunch 6 6 abcdefghijklmnopqrstuvwxyz0123456789 -o output/0ALL-1-4.txt
crunch 1 2 abcdefghijklmnopqrstuvwxyz0123456789 -o output/0AL-1-2.txt
