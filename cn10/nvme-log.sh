#!/bin/bash

#--------------- SETTINGS----------------
filename='test.log'
bsize="128M"
numjobs=8
annot="test"
directory="/mnt/lustre/"
sig_dir="/mnt/share/cykim/signal"
#---------------------------------------



#ssh - start nvme-cli script for each pm node
ssh pm001 'sh /mnt/share/cykim/pm/receiver.sh 1'
ssh pm002 'sh /mnt/share/cykim/pm/receiver.sh 2'
ssh pm003 'sh /mnt/share/cykim/pm/receiver.sh 3'
echo "OFF" > ${sig_dir}/msg1
echo "OFF" > ${sig_dir}/msg2
echo "OFF" > ${sig_dir}/msg3
sleep 1

# OST nodes CHECK Sequence
while true
do
	sleep 0.1
	checkmsg=`cat ${sig_dir}/msg1`
	if [[ $checkmsg == "ON" ]]; then
		rm -rf ${sig_dir}/msg1
		echo "OST node 1 - ON"
		break
	fi
done

while true
do
	sleep 0.1
	checkmsg=`cat ${sig_dir}/msg2`
	if [[ $checkmsg == "ON" ]]; then
		rm -rf ${sig_dir}/msg2
		echo "OST node 2 - ON"
		break
	fi
done

while true
do
	sleep 0.1
	checkmsg=`cat ${sig_dir}/msg3`
	if [[ $checkmsg == "ON" ]]; then
		rm -rf ${sig_dir}/msg3
		echo "OST node 3 - ON"
		break
	fi
done

# FLYER - start command
echo 1 > ${sig_dir}"/flyer1"
echo 1 > ${sig_dir}"/flyer2"
echo 1 > ${sig_dir}"/flyer3"
sleep 1


#fio
echo "FIO start - bsize: "${bsize}", numjobs: "${numjobs}
output=`fio --directory=${directory} --name=test --rw=write --direct=0 --bs=1M --size=${bsize} --numjobs=${numjobs} --group_reporting --fallocate=none`

#clat percentiles (usec)
percentile_95=`echo $output | cut -d'[' -f13 | cut -d']' -f1`
percentile_99=`echo $output | cut -d'[' -f14 | cut -d']' -f1`
percentile_999=`echo $output | cut -d'[' -f16 | cut -d']' -f1`
percentile_9999=`echo $output | cut -d'[' -f18 | cut -d']' -f1`

#Write Bandwidth
throughput=`echo $output | cut -d'[' -f18 | cut -d'(' -f5 | cut -d'M' -f1`

# fLYER - end command
echo 1 > ${sig_dir}"/flyer1"
echo 1 > ${sig_dir}"/flyer2"
echo 1 > ${sig_dir}"/flyer3"
sleep 1

waf1=`cat ${sig_dir}/result-waf1` && rm -rf ${sig_dir}/result-waf1
waf2=`cat ${sig_dir}/result-waf2` && rm -rf ${sig_dir}/result-waf2
waf3=`cat ${sig_dir}/result-waf3` && rm -rf ${sig_dir}/result-waf3

echo "["${bsize}","${numjobs}","${annot}"] "$percentile_95 $percentile_99 $percentile_999 $percentile_9999 $throughput $waf1 $waf2 $waf3 >> $filename

cat $filename

exit 0
