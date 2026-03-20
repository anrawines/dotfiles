#!/usr/bin/python3
# pip3 install --user subprocess argparse
# though note: subprocess and argparse are standard library modules, 
# so you might not actually need any external dependencies

import subprocess
import argparse
import os

SAVED_DEVICES = {
    'alsa_output.usb-0600_USBGH8-Plus-7.1-00.analog-stereo': '󰋎 ',
    'alsa_output.pci-0000_00_09.2.analog-stereo': '󰜟 '
}
POLYBAR_PATH = f'/home/{os.getlogin()}/.config/i3/polybar'
data_path = os.path.join(POLYBAR_PATH, 'scripts/data/audio_manager.txt')

parser = argparse.ArgumentParser(description="Switch audio output")
parser.add_argument(
    "number",
    type=int,
    nargs="?",
    default=0,
    help="Direction to switch device"
)
args = parser.parse_args()
direction = args.number

# Read previously active device
previously_active = None
try:
    with open(data_path, 'r') as file:
        previously_active = file.read().strip()
        if previously_active and previously_active in SAVED_DEVICES:
            print(SAVED_DEVICES[previously_active])
except FileNotFoundError:
    # Create file if it doesn't exist
    with open(data_path, 'w') as file:
        file.write('')

# Get active sinks
active_raw = subprocess.getoutput("pactl list short sinks").splitlines()
active_sinks = []

for line in active_raw:
    tmp = line.split()[1]
    if tmp in SAVED_DEVICES.keys():
        active_sinks.append(tmp)

# If just displaying (direction == 0) and we have a previously active device, exit
if direction == 0 and previously_active in active_sinks:
    exit()

# Find current active index
active_id = 0
if previously_active in active_sinks:
    active_id = active_sinks.index(previously_active)

# Calculate new index
new_id = active_id + direction
if new_id >= len(active_sinks):
    new_id = 0
elif new_id < 0:
    new_id = len(active_sinks) - 1

new_active = active_sinks[new_id]

# Set default sink
subprocess.Popen(
    ['pactl', 'set-default-sink', new_active],
    stdout=subprocess.DEVNULL,
    stderr=subprocess.DEVNULL,
    stdin=subprocess.DEVNULL,
    close_fds=True
)

# Save new active device
with open(data_path, 'w') as f:
    f.write(new_active)

# Output for Polybar
print(SAVED_DEVICES[new_active])
