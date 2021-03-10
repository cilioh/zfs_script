#!/bin/bash

#sh /mnt/share/cykim/backup/lustre-reboot.sh cn
#ssh pm1 "sh /mnt/share/cykim/backup/lustre-reboot.sh oss1"
#ssh mds2 "sh /mnt/share/cykim/backup/lustre-reboot.sh mdt"
sleep 20

ssh mds2 "sh /mnt/share/cykim/backup/lustre-start.sh mdt"
#ssh pm1 "sh /mnt/share/cykim/backup/lustre-start.sh oss1 $1 $2 $3 $4 $5"
ssh pm1 "sh /mnt/share/cykim/backup/lustre-start.sh oss1"
sh /mnt/share/cykim/backup/lustre-start.sh cn

#ssh pm1 "zfs set checksum=off ost0"
#ssh pm1 "zfs set checksum=off ost1"
#ssh pm1 "zfs set checksum=off ost2"
#ssh pm1 "zfs set checksum=off ost3"

fio --directory=/mnt/lustre --name=check -rw=write --direct=0 --bs=1M --size=16G --numjobs=8 --group_reporting --fallocate=none

#ssh pm1 "grep -nr \"jw\" /proc/spl/kstat/zfs/dbgmsg > /home/kau/jwbang/test"

sh /mnt/share/cykim/backup/lustre-reboot.sh cn
ssh pm1 "sh /mnt/share/cykim/backup/lustre-reboot.sh oss1"
ssh mds2 "sh /mnt/share/cykim/backup/lustre-reboot.sh mdt"

ssh mds2 "echo 3 > /proc/sys/vm/drop_caches"
ssh pm1 "echo 3 > /proc/sys/vm/drop_caches"
echo 3 > /proc/sys/vm/drop_caches

sleep 20
