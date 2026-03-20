#!/bin/bash

# Function to get current status
get_wifi_status() {
    if nmcli radio wifi | grep -q "enabled"; then
        echo "WiFi: ON"
    else
        echo "WiFi: OFF"
    fi
}

get_bluetooth_status() {
    if bluetoothctl show | grep -q "Powered: yes"; then
        echo "Bluetooth: ON"
    else
        echo "Bluetooth: OFF"
    fi
}

CHOICE_FILE=$(mktemp)

alacritty --class network-selector -e bash -c "
current_wifi=\"\$(nmcli radio wifi | grep -q enabled && echo 'WiFi: ON' || echo 'WiFi: OFF')\"
current_bt=\"\$(bluetoothctl show | grep -q 'Powered: yes' && echo 'Bluetooth: ON' || echo 'Bluetooth: OFF')\"

printf '%s\n' \
  'Toggle WiFi' \
  'Toggle Bluetooth' \
  '---' \
  'Connect to WiFi' \
  'Connect Bluetooth Device' \
  '---' \
  '\$current_wifi' \
  '\$current_bt' | \
  fzf --no-input --layout=reverse --border \
  --border-label 'Network & Bluetooth Control' \
  --header 'Current Status:' > '$CHOICE_FILE'
"

if [ -s "$CHOICE_FILE" ]; then
    choice=$(cat "$CHOICE_FILE")
    
    case "$choice" in
        "Toggle WiFi")
            if nmcli radio wifi | grep -q "enabled"; then
                nmcli radio wifi off
                notify-send "WiFi" "Turned OFF"
            else
                nmcli radio wifi on
                notify-send "WiFi" "Turned ON"
            fi
            ;;
            
        "Toggle Bluetooth")
            if bluetoothctl show | grep -q "Powered: yes"; then
                bluetoothctl power off
                notify-send "Bluetooth" "Turned OFF"
            else
                bluetoothctl power on
                notify-send "Bluetooth" "Turned ON"
            fi
            ;;
            
        "Connect to WiFi")
            # Get available networks
            networks=$(nmcli -t -f SSID,SECURITY,SIGNAL dev wifi list | \
                      fzf --header="Select WiFi network (SSID | Security | Signal)" \
                          --layout=reverse)
            if [ -n "$networks" ]; then
                ssid=$(echo "$networks" | cut -d: -f1)
                # Check if password is needed
                if echo "$networks" | grep -q "WPA\|WEP"; then
                    # Launch password prompt in new alacritty window
                    alacritty --class wifi-password -e bash -c "
                        read -p 'Enter password for $ssid: ' password
                        nmcli dev wifi connect '$ssid' password '\$password'
                        read -p 'Press Enter to close...'
                    "
                else
                    nmcli dev wifi connect "$ssid"
                fi
                notify-send "WiFi" "Connected to $ssid"
            fi
            ;;
            
        "Connect Bluetooth Device")
            # Start scanning
            notify-send "Bluetooth" "Scanning for devices..."
            bluetoothctl scan on &
            scan_pid=$!
            sleep 4
            
            # Get available devices
            devices=$(bluetoothctl devices | \
                     fzf --header="Select Bluetooth device (MAC | Name)" \
                         --layout=reverse)
            
            # Stop scanning
            kill $scan_pid 2>/dev/null
            
            if [ -n "$devices" ]; then
                mac=$(echo "$devices" | awk '{print $2}')
                name=$(echo "$devices" | cut -d' ' -f3-)
                
                # Try to connect
                bluetoothctl pair "$mac"
                bluetoothctl trust "$mac"
                bluetoothctl connect "$mac"
                
                if [ $? -eq 0 ]; then
                    notify-send "Bluetooth" "Connected to $name"
                else
                    notify-send -u critical "Bluetooth" "Failed to connect to $name"
                fi
            fi
            ;;
    esac
    
    rm "$CHOICE_FILE"
fi
