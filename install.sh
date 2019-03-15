#!/usr/bin/env bash
set -eou pipefail
cd "$(dirname "$0")/"
if [ "$#" -lt 1 ]; then
    echo "Usage: $0 [exe name]"
    exit 1
fi

ssh root@192.168.129.1 'mount -o remount,rw /; passwd -d root'
scp -r etc home root@192.168.129.1:/
echo "alias kp='killall $1'" | ssh root@192.168.129.1 "cat >> /home/root/.profile"
