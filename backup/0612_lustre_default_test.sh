#!/bin/bash

directory="/mnt/lustre"
sig_dir="/mnt/share/cykim/signal"
nodename="CN7"
filename="apple"
todaydate=`date "+%m%d"`
todaytime=`date "+%H%M"`
SECONDS=0

mkdir -p /mnt/share/cykim/result/${todaydate}
echo ${todaydate}"-"${todaytime} > /mnt/share/cykim/result/${todaydate}/Result_${todaytime}_CN8.txt
echo ${todaydate}"-"${todaytime} > /mnt/share/cykim/result/${todaydate}/Result_${todaytime}_CN9.txt

#for bsize in "4G"
for bsize in "4G" "8G" "16G" "32G"
do
#	for numjobs in "4"
	for numjobs in "1" "2" "4" "8" "16"
	do
#		for stripecount in "8"
		for stripecount in "1" "2" "4" "8" "12" "24"
		do
			lfs setstripe -c ${stripecount} /mnt/lustre
			ssh cn9 "lfs setstripe -c "${stripecount}" /mnt/lustre"
#			for iter in {1..2}
			for iter in {1..5}
			do
				rm -rf /mnt/lustre/*
				sleep 2

				echo 3 > /proc/sys/vm/drop_caches
				ssh cn9 'echo 3 > /proc/sys/vm/drop_caches'
				sleep 1

				echo "OFF" > ${sig_dir}/CN8
				echo "OFF" > ${sig_dir}/CN9

				/mnt/share/cykim/backup/fio_script.sh ${bsize} ${numjobs} "CN8" "apple" ${stripecount} ${todaydate} ${todaytime} ${iter} &
				ssh cn9 "/mnt/share/cykim/backup/fio_script.sh" ${bsize} ${numjobs} "CN9" "banana" ${stripecount} ${todaydate} ${todaytime} ${iter}

				while true
				do
					#count=0
					msg=`cat ${sig_dir}/CN8`
					if [[ $msg == "ON" ]]; then
						break	
					#	msg2=`cat ${sig_dir}/cn9`
					#	if [[ $msg2 == "ON" ]]; then
					#		count=1
					#	fi
					fi
					sleep 5
				done

				totval=`lfs df -h | awk '$1=="filesystem_summary:" { print $5 }' | grep -oP '\d+'`
				if [ $totval -ge 98 ]; then
					echo " LUSTRE storage 98% FULL --- EMPTY "
					rm -rf ${directory}/${filename}*
					echo "-"
				fi
			done
		done
	done
done

duration=$SECONDS
echo "$(($duration / 60)) minutes and $(($duration % 60)) seconds elapsed. SCRIPT DONE"

exit 0
