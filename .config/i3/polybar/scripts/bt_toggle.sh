#!/bin/bash

# Cek apakah Bluetooth sedang menyala
STATUS=$(bluetoothctl show | grep "Powered: yes")

if [ -z "$STATUS" ]; then
    # Jika mati: buka blokir kernel DULU, baru nyalakan power
    rfkill unblock bluetooth
    sleep 0.5
    if bluetoothctl power on; then
        notify-send "Bluetooth" "Powered ON" --icon=bluetooth-active
    else
        notify-send "Bluetooth" "FAILED to start" --icon=error
    fi
else
    # Jika nyala: matikan power
    bluetoothctl power off
    notify-send "Bluetooth" "Powered OFF" --icon=bluetooth-disabled
fi

# Letakkan di sini agar jalan baik saat ON maupun OFF
polybar-msg action "#bluetooth.module_update" 2>/dev/null
