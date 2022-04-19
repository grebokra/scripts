#!/bin/bash
# NOTE: This script may not work or even could harm. Use with caution!!!

set -euo pipefail

devices=$(ls -1 /dev/video* | while read line; do echo $line "$(udevadm info --query=symlink $line)"; done  \
    | egrep -i 'camera' | while read penis; do echo $penis | cut -d' ' -f1; done)

if [[ -n $(ls -l $devices | grep 'rw-rw----') ]]; then
    sudo chmod 0000 $devices
    echo Webcam disabled!
else
    sudo chmod 0660 $devices
    echo Webcam enabled!
fi

