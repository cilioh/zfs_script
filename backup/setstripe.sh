#!/bin/bash

sig_dir="/mnt/share/cykim/signal"

for ss in 1 2 3 4 5 6 8 16 32 64 128
do
	echo $ss > ${sig_dir}/setstripe
	sleep 0.1

	lfs setstripe -c ${ss} /mnt/lustre
	
	# mc
	#ssh cn8 'lfs setstripe -c '${ss}' /mnt/lustre'
	#ssh cn9 'lfs setstripe -c '${ss}' /mnt/lustre'
	#ssh cn10 'lfs setstripe -c '${ss}' /mnt/lustre'

#	lfs getstripe -d /mnt/lustre
	sh /root/lustre-compute/nvme-log.sh
	rm -rf /mnt/lustre/*
	sleep 3s
done
