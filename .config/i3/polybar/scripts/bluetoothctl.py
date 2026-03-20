#!/usr/bin/python3

import subprocess
import re

def get_devices():
    """Get paired devices using bluetoothctl (no PyBluez needed)"""
    result = subprocess.getoutput('bluetoothctl devices')
    devices = {}
    for line in result.splitlines():
        parts = line.split()
        if len(parts) >= 3:
            mac = parts[1]
            name = ' '.join(parts[2:])
            devices[name] = mac
    return devices

def discover_devices():
    """Discover nearby devices using bluetoothctl"""
    # Start discovery
    subprocess.run(['bluetoothctl', 'scan', 'on'], timeout=2)
    
    # Give it time to discover
    import time
    time.sleep(5)
    
    # Get discovered devices
    result = subprocess.getoutput('bluetoothctl devices')
    subprocess.run(['bluetoothctl', 'scan', 'off'])
    
    devices = {}
    for line in result.splitlines():
        parts = line.split()
        if len(parts) >= 3:
            mac = parts[1]
            name = ' '.join(parts[2:])
            devices[name] = mac
    return devices

# Then use these functions in your menu script instead of the bluetooth module
