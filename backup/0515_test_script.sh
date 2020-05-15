#!/bin/bash


#Loop
for stripe in 1 2 3 4 5 6
do
	echo "ON" > ${sig_dir}/breaksig
	sleep 1

	#Set Stripe Count
	lfs setstripe -c ${stripe} /mnt/lustre
	ssh cn8 'lfs setstripe -c '${stripe}' /mnt/lustre'
	ssh cn9 'lfs setstripe -c '${stripe}' /mnt/lustre'
	ssh cn10 'lfs setstripe -c '${stripe}' /mnt/lustre'
	sleep 1

	#Terminate Timer - 60 minutes
	#Placeholder on pm_waf#.txt
	/mnt/share/cykim/backup/60min_timer.sh &
	sleep 1

	#PM node WAF calculator ON
	ssh pm1 '/mnt/share/cykim/backup/waf_monitor_pm.sh 1' &
	ssh pm2 '/mnt/share/cykim/backup/waf_monitor_pm.sh 2' &
	ssh pm3 '/mnt/share/cykim/backup/waf_monitor_pm.sh 3' &

	#FIO - Record Throughput & Latency
	ssh cn8 'sh /mnt/share/cykim/backup/load_stress_gc.sh 256MB 16 CN8 banana' &
	ssh cn9 'sh /mnt/share/cykim/backup/load_stress_gc.sh 1G 16 CN9 citrus' &
	ssh cn10 'sh /mnt/share/cykim/backup/load_stress_gc.sh 4G 16 CN10 dragonfruit' &
	sh /mnt/share/cykim/backup/load_stress_gc.sh 64MB 16 CN7 apple &

	#Wait for 60 minutes
	while true
	do
		msgc=`cat /mnt/share/cykim/signal/breaksig`
		if [[ $msgc == "OFF" ]]; then
			break
		fi
		sleep 5
	done
done
#Loop END

exit 0
