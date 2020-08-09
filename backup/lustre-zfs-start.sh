#!/bin/bash

mdsname="mds2"

echo "mdt / oss1 / cn"

modprobe lustre
sleep 2

modprobe zfs
sleep 2

modprobe lnet
sleep 2

lctl lustre_build_version
sleep 2

lctl network configure
sleep 2

lnetctl net add --net o2ib --if ib0
sleep 2

if [[ $1 == "mdt" ]]; then
	mkfs.lustre --mdt --mgs --fsname=lustre --backfstype=zfs --reformat --index=0 mdt/mdt0 /dev/sdc
	sleep 5

	mkdir -p /lustre/mdt
	mount -t lustre mdt/mdt0 /lustre/mdt
	df -h
fi

if [[ $1 == "oss1" ]]; then

	mkfs.lustre --ost --backfstype=zfs --index=1 --reformat --mgsnode=${mdsname}i@o2ib --fsname=lustre ost0/ost0 /dev/nvme0n1
	sleep 2
	mkfs.lustre --ost --backfstype=zfs --index=2 --reformat --mgsnode=${mdsname}i@o2ib --fsname=lustre ost1/ost1 /dev/nvme1n1
	sleep 2
	mkfs.lustre --ost --backfstype=zfs --index=3 --reformat --mgsnode=${mdsname}i@o2ib --fsname=lustre ost2/ost2 /dev/nvme2n1
	sleep 2
	mkfs.lustre --ost --backfstype=zfs --index=4 --reformat --mgsnode=${mdsname}i@o2ib --fsname=lustre ost3/ost3 /dev/nvme3n1
	sleep 2
fi

if [[ $1 == "oss1m" ]]; then

	mount -t lustre ost0/ost0 /lustre/ost0
	mount -t lustre ost1/ost1 /lustre/ost1
	mount -t lustre ost2/ost2 /lustre/ost2
	mount -t lustre ost3/ost3 /lustre/ost3

	mount -t lustre ost0/ost0 /lustre/ost0
	mount -t lustre ost1/ost1 /lustre/ost1
	mount -t lustre ost2/ost2 /lustre/ost2
	mount -t lustre ost3/ost3 /lustre/ost3
	df -h
fi

if [[ $1 == "oss2" ]]; then

	mkfs.lustre --ost --backfstype=ldiskfs --index=5 --reformat --mgsnode=pm4i@o2ib --fsname=lustre /dev/nvme0n1
	sleep 2
	mkfs.lustre --ost --backfstype=ldiskfs --index=6 --reformat --mgsnode=pm4i@o2ib --fsname=lustre /dev/nvme1n1
	sleep 2
	mkfs.lustre --ost --backfstype=ldiskfs --index=7 --reformat --mgsnode=pm4i@o2ib --fsname=lustre /dev/nvme2n1
	sleep 2
	mkfs.lustre --ost --backfstype=ldiskfs --index=8 --reformat --mgsnode=pm4i@o2ib --fsname=lustre /dev/nvme3n1
	sleep 2
fi

if [[ $1 == "oss2m" ]]; then

	mount -t lustre /dev/nvme0n1 /lustre/ost4
	mount -t lustre /dev/nvme1n1 /lustre/ost5
	mount -t lustre /dev/nvme2n1 /lustre/ost6
	mount -t lustre /dev/nvme3n1 /lustre/ost7

	mount -t lustre /dev/nvme0n1 /lustre/ost4
	mount -t lustre /dev/nvme1n1 /lustre/ost5
	mount -t lustre /dev/nvme2n1 /lustre/ost6
	mount -t lustre /dev/nvme3n1 /lustre/ost7
	df -h
fi

if [[ $1 == "oss3" ]]; then

	mkfs.lustre --ost --backfstype=ldiskfs --index=9 --reformat --mgsnode=pm4i@o2ib --fsname=lustre /dev/nvme0n1
	sleep 2
	mkfs.lustre --ost --backfstype=ldiskfs --index=10 --reformat --mgsnode=pm4i@o2ib --fsname=lustre /dev/nvme1n1
	sleep 2
	mkfs.lustre --ost --backfstype=ldiskfs --index=11 --reformat --mgsnode=pm4i@o2ib --fsname=lustre /dev/nvme2n1
	sleep 2
	mkfs.lustre --ost --backfstype=ldiskfs --index=12 --reformat --mgsnode=pm4i@o2ib --fsname=lustre /dev/nvme3n1
	sleep 2
fi

if [[ $1 == "oss3m" ]]; then
	mount -t lustre /dev/nvme0n1 /lustre/ost8
	mount -t lustre /dev/nvme1n1 /lustre/ost9
	mount -t lustre /dev/nvme2n1 /lustre/ost10
	mount -t lustre /dev/nvme3n1 /lustre/ost11

	mount -t lustre /dev/nvme0n1 /lustre/ost8
	mount -t lustre /dev/nvme1n1 /lustre/ost9
	mount -t lustre /dev/nvme2n1 /lustre/ost10
	mount -t lustre /dev/nvme3n1 /lustre/ost11
	df -h
fi

if [[ $1 == "cn" ]]; then

	mount -t lustre ${mdsname}i@o2ib:/lustre /mnt/lustre
	sleep 3
	chmod 777 /mnt/lustre
	sleep 2
	lfs df -h
fi

exit 0
