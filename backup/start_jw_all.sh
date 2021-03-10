#!/bin/bash

ssh mds2 "sh /mnt/share/cykim/backup/lustre-zfs-start.sh mdt"
ssh pm1 "sh /mnt/share/cykim/backup/lustre-zfs-start.sh oss1"
sh /mnt/share/cykim/backup/lustre-zfs-start.sh cn



