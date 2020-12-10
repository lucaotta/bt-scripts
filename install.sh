#!/usr/bin/env bash
set -eou pipefail
cd "$(dirname "$0")/"
if [ "$#" -lt 1 ]; then
    echo "Usage: $0 [GUI exe name]"
    exit 1
fi

ssh root@192.168.129.1 'mount -o remount,rw /; passwd -d root'
scp -qr etc home root@192.168.129.1:/
echo "alias kp='killall -9 $1'" | ssh root@192.168.129.1 "cat >> /home/root/.profile"
# Disable watchdog
scp -q root@192.168.129.1:/var/tmp/stack_open.xml /tmp/
# Enable back application level capabilities to run
ssh root@192.168.129.1 '/sbin/fw_setenv runlevel 5'
# Remove watchdog
python_ret=$(python -c "from xml.etree import ElementTree as et; tree = et.parse('/tmp/stack_open.xml'); tree.getroot().find('sw/wdt/enable').text = '0'; tree.getroot().find('sw/${1}/logverbosity').text = '0x3F';tree.write('/tmp/stack_open.xml');")
if [[ $python_ret -eq 0 ]]; then
    scp -q /tmp/stack_open.xml root@192.168.129.1:/var/tmp/stack_open.xml
fi
ssh root@192.168.129.1 '/sbin/reboot'
# We have restarted the system, the device will change the ssh key. Remove any stored entry
ssh-keygen -R 192.168.129.1
