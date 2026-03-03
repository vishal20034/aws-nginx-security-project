#!/bin/bash

LOG_FILE="/var/log/nginx/access.log"
THRESHOLD=3

awk '{print $1}' $LOG_FILE | sort | uniq -c | sort -nr | while read count ip
do
    if [ "$count" -gt "$THRESHOLD" ]; then
        sudo ufw deny from $ip
        echo "Blocked IP: $ip with $count requests"
    fi
done
