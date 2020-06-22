#!/bin/bash

todaydate=${1}
todaytime=${2}
nodename=${3}

msg=$(ssh pm1 'pidof iostat')
if [[ $msg == "" ]]; then
	sleep 0.1
else
	ssh pm1 'kill -9 $(pidof iostat)'
	ssh pm2 'kill -9 $(pidof iostat)'
#	ssh pm3 'kill -9 $(pidof iostat)'
fi

sleep 1
pm1result=`python iostat_oss.py /mnt/share/cykim/result/output1`
pm2result=`python iostat_oss.py /mnt/share/cykim/result/output2`
#pm3result=`python iostat_oss.py /mnt/share/cykim/result/output3`

out=`cat /mnt/share/cykim/result/${nodename}.txt`
#echo ${out}","${pm1result}","${pm2result}","${pm3result} >> /mnt/share/cykim/result/${todaydate}/Result_${todaytime}_${nodename}.txt
echo ${out}","${pm1result}","${pm2result} >> /mnt/share/cykim/result/${todaydate}/Result_${todaytime}_${nodename}.txt
#echo ${out}","${pm1result} >> /mnt/share/cykim/result/${todaydate}/Result_${todaytime}_${nodename}.txt

