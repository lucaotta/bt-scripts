alias tc='touch /var/tmp/conf.xml'
alias t='tail -f /var/tmp/BTicino.log'
alias ll='ls -l'
alias la='ls -a'
alias eye='sendopen --opencommand "*11*4#20*20##"'
alias telephone='sendopen --opencommand "*8*84*11##"; sleep 0.1; sendopen --opencommand "*8*85*11##";'
alias alexa-mute='sendopen --opencommand *7*70#9##'
alias alexa-unmute='sendopen --opencommand *7*70#8##'
alias fw-prepare-update='echo 0 > /sys/block/mmcblk0boot0/force_ro; dd if=/dev/zero of=/dev/mmcblk0boot0 bs=1M count=1; echo 1 > /sys/block/mmcblk0boot0/force_ro;'
alias fw-version='cat /home/bticino/sp/dbfiles_ws.xml | grep ver_webserver | colrm 1 21 | cut --delimiter="<" --fields=1'
cd /home/bticino
