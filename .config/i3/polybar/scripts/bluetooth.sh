#!/bin/bash
# Cek apakah bluetooth aktif
if [ $(bluetoothctl show | grep "Powered: yes" | wc -l) -gt 0 ]; then
  # Cek apakah ada perangkat terhubung
  device=$(bluetoothctl info | grep "Name" | cut -d ' ' -f 2-)
  if [ -z "$device" ]; then
    echo "" # Aktif tapi tidak ada device
  else
    echo " $device" # Menampilkan nama device
  fi
else
  echo "󰂲" # Bluetooth mati
fi
