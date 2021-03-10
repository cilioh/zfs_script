#!/bin/bash


sh /mnt/share/cykim/backup/lustre-reboot.sh cn
ssh pm1 "sh /mnt/share/cykim/backup/lustre-reboot.sh oss1"
ssh mds2 "sh /mnt/share/cykim/backup/lustre-reboot.sh mdt"


