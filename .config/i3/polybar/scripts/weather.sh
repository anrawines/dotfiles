#!/bin/bash
# Tambahkan 'xargs' untuk membersihkan whitespace
#weather=$(curl -s "wttr.in/Jakarta?format=%t" | tr -d '[:space:]')
weather=$(curl -s "wttr.in/Batam?format=%t" | tr -d '[:space:]' | tr -d '+')
interval=60000

if [[ $weather == *"unknown"* ]] || [ -z "$weather" ]; then
    echo "N/A"
else
    echo "$weather"
fi
