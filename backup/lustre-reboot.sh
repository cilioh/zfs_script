#!/bin/bash

if [[ ${1} == "cn" ]]; then

#        for cli in "cn7" "cn8" "cn9" "cn10"
#        do
#                ssh $cli 'umount /mnt/lustre'
#                ssh $cli 'modprobe -r lustre'
#                ssh $cli 'lctl network down'
#                ssh $cli 'lustre_rmmod'
#                ssh $cli 'modprobe -r lnet'
#                echo "${cli} - lustreFS DOWN"
#        done
	umount /mnt/lustre
	modprobe -r lustre
	lctl network down
	lustre_rmmod
	modprobe -r lnet
	echo "client - FS Down"
fi

ostnum=0
if [[ ${1} == "oss" ]]; then

        for oss in "pm3" #"pm001" "pm002" "pm003"
        do
#                ssh $oss 'umount /lustre/ost'${ostnum}
#                ssh $oss 'zpool destroy ost'${ostnum}
#                ostnum=`expr $ostnum + 1`
#		ssh $oss 'umount /lustre/ost'${ostnum}
#                ssh $oss 'zpool destroy ost'${ostnum}
               # ostnum=`expr $ostnum + 1`
#		ssh $oss 'umount /lustre/ost'${ostnum}
#                ssh $oss 'zpool destroy ost'${ostnum}
#                ostnum=`expr $ostnum + 1`
#                ostnum=`expr $ostnum + 1`
#		ssh $oss 'zpool destroy ost'

		ssh $oss 'umount /lustre/ost'${ostnum}
                ostnum=`expr $ostnum + 1`
#		ssh $oss 'umount /lustre/ost'${ostnum}
#                ostnum=`expr $ostnum + 1`
#		ssh $oss 'umount /lustre/ost'${ostnum}
#                ostnum=`expr $ostnum + 1`
#		ssh $oss 'umount /lustre/ost'${ostnum}
 #               ostnum=`expr $ostnum + 1`

                ssh $oss 'modprobe -r lustre'
		ssh $oss 'lctl network down'
                ssh $oss 'lustre_rmmod'
		ssh $oss 'systemctl kill zfs-zed'
		ssh $oss 'modprobe -r zfs'
                ssh $oss 'modprobe -r lnet'
                echo "${oss} - lustreFS DOWN"
        done
fi

if [[ ${1} == "mdt" ]]; then

#	mdtip="192.168.0.204"
#	ssh $mdtip 'umount /lustre/mdt'
	ssh 192.168.0.204 'zpool destroy mdt'
	ssh 192.168.0.204 'modprobe -r lustre'
	ssh 192.168.0.204 'lctl network down'
	ssh 192.168.0.204 'lustre_rmmod'
	ssh 192.168.0.204 'systemctl kill zfs-zed'
	ssh 192.168.0.204 'modprobe -r zfs'
	ssh 192.168.0.204 'modprobe -r lnet'
	echo "MDT - lustreFS DOWN"
fi
