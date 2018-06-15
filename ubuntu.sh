#!/bin/bash
FILE="/root/firstboot.txt"
if [ -f $FILE ];
then
   echo "File $FILE exist. No script running"
else
   echo "1. Change to local repositoy" >> /root/firstboot.txt
   echo "2. Update system for the first time" >> /root/firstboot.txt 
   echo "3. Disable SSH password login" >> /root/firstboot.txt
   echo "4. Remove LXD and Snapd" >> /root/firstboot.txt
   echo "5. Change time to local timezone Asia/Ho_Chi_Minh" >> /root/firstboot.txt
   echo "6. Reboot"
   echo "*** ONLY REMOVE THIS FILE IF YOU NEED TO RUN THIS SCRIPT IN NEXT BOOT ***"
   sed -i 's/archive.ubuntu.com/mirror.clearsky.vn/g' /etc/apt/sources.list
   sed -i 's/PasswordAuthentication\ yes/PasswordAuthentication\ no/g' /etc/ssh/sshd_config
   apt update >> /root/firstboot.txt
   apt purge lxd* snapd* -y --autoremove
   DEBIAN_FRONTEND='noninteractive' apt -y -o Dpkg::Options::='--force-confdef' -o Dpkg::Options::='--force-confold' dist-upgrade
   timedatectl set-timezone Asia/Ho_Chi_Minh
   reboot
fi
