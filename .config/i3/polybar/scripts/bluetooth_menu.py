#!/usr/bin/python3

from subprocess import getoutput as cmd
import bluetooth
from pydbus import SystemBus
from gi.repository import GLib
import time

def draw_menu(content):
    options = "\n".join(content)
    while True:
        result = cmd(f'echo "{options}" | rofi -dmenu -p "Bluetooth"')
        if result != '- - - - -':
            return result

def get_devices():
    cmd_out = cmd('bluetoothctl devices')
    if cmd_out == '':
        return {}
    
    result = {}
    for line in cmd_out.splitlines():
        tmp = line.split()
        result[' '.join(tmp[2:])] = tmp[1]

    return result

options_main = [
    '- - - - -',
    'Pair New Device',
    'Toggle Bluetooth'
]


while True:
    menu_main = list(get_devices().keys()) + options_main
    
    choice = draw_menu(menu_main)
    
    if not choice:
        break
    elif choice == 'Toggle Bluetooth':
        if 'Powered: yes' in cmd('bluetoothctl show'):
            cmd('bluetoothctl power off')
        else:
            cmd('bluetoothctl power on')

    elif choice == 'Pair New Device':
        if 'Powered: yes' in cmd('bluetoothctl show'):

            scanned_devices = bluetooth.discover_devices(duration=5, lookup_names=True)
            
            nearby_devices = {}
            for addr, name in scanned_devices:
                nearby_devices[name] = addr
            
            choice = draw_menu(list(nearby_devices.keys()))
            mac = nearby_devices[choice]
            

            bus = SystemBus()
            mngr = bus.get("org.bluez", "/")

            ADAPTER = None
            DEVICE_MAC_DBUS = mac.replace(":", "_")

            # znajdź adapter
            objects = mngr.GetManagedObjects()
            for path, ifaces in objects.items():
                if "org.bluez.Adapter1" in ifaces:
                    ADAPTER = path
                    break

            adapter = bus.get("org.bluez", ADAPTER)
            adapter.Powered = True

            # start skanowania
            adapter.StartDiscovery()

            device_path = None
            timeout = time.time() + 20

            while time.time() < timeout:
                objects = mngr.GetManagedObjects()
                for path, ifaces in objects.items():
                    if "org.bluez.Device1" in ifaces:
                        if path.endswith(DEVICE_MAC_DBUS):
                            device_path = path
                            break
                if device_path:
                    break
                time.sleep(0.2)

            adapter.StopDiscovery()

            device = bus.get("org.bluez", device_path)

            # PAROWANIE
            if not device.Paired:
                device.Pair()
    else:
        if 'Powered: yes' in cmd('bluetoothctl show'):
            dev_name = choice
            mac = get_devices()[dev_name]

            connected = False if 'Connected: no' in cmd(f'bluetoothctl info {mac}') else True

            options = [
                dev_name,
                '- - - - -',
                'disconnect' if connected else 'connect',
                'remove'
            ]

            choice = draw_menu(options)

            if choice == 'remove':
                cmd(f'bluetoothctl remove {mac}')
            elif choice == options[2]:
                cmd(f'bluetoothctl {choice} {mac}')