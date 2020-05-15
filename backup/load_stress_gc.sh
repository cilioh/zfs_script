#!/bin/bash

bsize=${1}
numjobs=${2}
nodename=${3}
filename=${4}
stripecount=${5}

directory="/mnt/lustre"
sig_dir="/mnt/share/cykim/signal"
iternum=1

#Drop Caches
echo 3 > /proc/sys/vm/drop_caches
sleep 5

while true
do
	#Break Loop Sequence
	breaksig=`cat ${sig_dir}/breaksig`
	if [[ $breaksig == "OFF" ]]; then
		break
	fi

	sleep 1

	#FIO
	output=`fio --directory=${directory} --name=${filename}${iternum} --rw=write --direct=0 --bs=1M --size=${bsize} --numjobs=${numjobs} --group_reporting --fallocate=none | awk '$1 == "WRITE:" { print $3 } /9[5-9].[0-9]+th/ { print }' | grep -oP '[\K\[\(][\s\d]\d+' | grep -oP '\d+' | tr '\n' ' ' | awk '{ print $4"," $5"," $7"," $9"," $10}'`

	#Result - ECHO
	echo ${nodename}","${bsize}","${numjobs}","${stripecount}","${iternum}","${output} >> /mnt/share/cykim/result/gc_throughput${nodename}.txt
	
	95per=`echo $output | cut -d',' -f1`
	99per=`echo $output | cut -d',' -f1`
	999per=`echo $output | cut -d',' -f1`
	9999per=`echo $output | cut -d',' -f1`
	th=`echo $output | cut -d',' -f1`
	echo "["${nodename}",BJ="${bsize}",NJ="${numjobs}",SC="${stripecount}",ITER-"${iternum}"] 95%=["${95per}"] 99%=["${99per}" 99.9%=["${999per}" 99.99%=["${9999per}"] Throughput=["${th}"]"
	sleep 1

	#File Remove
	if [ $iternum -gt 1 ]; then
		rmnum=`expr ${iternum} - 1`
		rm -rf ${directory}/${filename}${rmnum}.*
	fi

	#iteration
	iternum=`expr $iternum + 1`
	sleep 1
done

echo "["${nodename}",BS="${bsize}",NJ="${numjobs}",iter-"${iternum}"] terminated."

exit 0
