#!/bin/bash

sh /mnt/share/cykim/backup/lustre-reboot.sh cn
ssh pm1 "sh /mnt/share/cykim/backup/lustre-reboot.sh oss1"
ssh pm2 "sh /mnt/share/cykim/backup/lustre-reboot.sh oss2"
ssh pm3 "sh /mnt/share/cykim/backup/lustre-reboot.sh oss3"
ssh mds2 "sh /mnt/share/cykim/backup/lustre-reboot.sh mdt"
ssh mds2 "sh /mnt/share/cykim/backup/lustre-zfs-start.sh mdt"
ssh pm1 "sh /mnt/share/cykim/backup/lustre-zfs-start.sh oss1"
ssh pm2 "sh /mnt/share/cykim/backup/lustre-zfs-start.sh oss2"
ssh pm3 "sh /mnt/share/cykim/backup/lustre-zfs-start.sh oss3"
sh /mnt/share/cykim/backup/lustre-zfs-start.sh cn









