#!/bin/bash

echo "START----------" >> /mnt/share/cykim/result/pm_waf1.txt
echo "START----------" >> /mnt/share/cykim/result/pm_waf2.txt
echo "START----------" >> /mnt/share/cykim/result/pm_waf3.txt

for i in {1..3600}
do
	ck=`cat /mnt/share/cykim/signal/termall`
	if [[ $ck == "OFF" ]]; then
		echo 'timer off'
		exit 1
	fi
	sleep 1
done

echo "OFF" > /mnt/share/cykim/signal/breaksig

echo "END----------" >> /mnt/share/cykim/result/pm_waf1.txt
echo "END----------" >> /mnt/share/cykim/result/pm_waf2.txt
echo "END----------" >> /mnt/share/cykim/result/pm_waf3.txt

exit 0
