ssh root@192.168.129.1 'mount -o remount,rw /; passwd -d root'
scp -r etc home root@192.168.129.1:/
