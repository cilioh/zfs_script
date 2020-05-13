#!/bin/bash

sig_dir="/mnt/share/cykim/signal"
node_value=${1}

while true
do
	sleep 1

	#nvme command for WAF
	output=`nvme get-log /dev/nvme0n1 -i 0xc1 -l 128`
	user_writes_bf_0=`expr $(echo $output | awk '{print $22}' | cut -d'(' -f2 | cut -d')' -f1) + 0`
	nand_writes_bf_0=`expr $(echo $output | awk '{print $26}' | cut -d'(' -f2 | cut -d')' -f1) + 0`

	output=`nvme get-log /dev/nvme1n1 -i 0xc1 -l 128`
	user_writes_bf_1=`expr $(echo $output | awk '{print $22}' | cut -d'(' -f2 | cut -d')' -f1) + 0`
	nand_writes_bf_1=`expr $(echo $output | awk '{print $26}' | cut -d'(' -f2 | cut -d')' -f1) + 0`

	# interval
	sleep 119


	#nvme command for WAF
	output=`nvme get-log /dev/nvme0n1 -i 0xc1 -l 128`
	user_writes_at_0=`expr $(echo $output | awk '{print $22}' | cut -d'(' -f2 | cut -d')' -f1) + 0`
	nand_writes_at_0=`expr $(echo $output | awk '{print $26}' | cut -d'(' -f2 | cut -d')' -f1) + 0`

	output=`nvme get-log /dev/nvme1n1 -i 0xc1 -l 128`
	user_writes_at_1=`expr $(echo $output | awk '{print $22}' | cut -d'(' -f2 | cut -d')' -f1) + 0`
	nand_writes_at_1=`expr $(echo $output | awk '{print $26}' | cut -d'(' -f2 | cut -d')' -f1) + 0`

	#WAF
	if [ $nand_writes_bf_0 -eq $nand_writes_at_0 ]; then
	        WAF_0=-1
	else
	        WAF_0=$(echo "$nand_writes_bf_0 $user_writes_bf_0 $nand_writes_at_0 $user_writes_at_0" | awk '{printf "%.4f \n", ($3-$1)/($4-$2)}')
	fi

	if [ $nand_writes_bf_1 -eq $nand_writes_at_1 ]; then
	        WAF_1=-1
	else
	        WAF_1=$(echo "$nand_writes_bf_1 $user_writes_bf_1 $nand_writes_at_1 $user_writes_at_1" | awk '{printf "%.4f \n", ($3-$1)/($4-$2)}')
	fi

	echo $WAF_0 $WAF_1
done

exit 0
