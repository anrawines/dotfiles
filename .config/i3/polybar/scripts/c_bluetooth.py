#!/usr/bin/python3

import subprocess

on_icon = ''
off_icon = '󰂲'


bt_active = False
output = subprocess.getoutput("bluetoothctl show")

if 'Powered: yes' in output:
    bt_active = True

print(on_icon if bt_active else off_icon)
