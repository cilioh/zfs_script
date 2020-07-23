#!/bin/bash

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

	mkfs.lustre --ost --backfstype=zfs --index=1 --reformat --mgsnode=mds2i@o2ib --fsname=lustre ost/ost0 /dev/nvme0n1
	sleep 2
	mkfs.lustre --ost --backfstype=zfs --index=2 --reformat --mgsnode=mds2i@o2ib --fsname=lustre ost/ost1 /dev/nvme1n1
	sleep 2
	mkfs.lustre --ost --backfstype=zfs --index=3 --reformat --mgsnode=mds2i@o2ib --fsname=lustre ost/ost2 /dev/nvme2n1
	sleep 2
	mkfs.lustre --ost --backfstype=zfs --index=4 --reformat --mgsnode=mds2i@o2ib --fsname=lustre ost/ost3 /dev/nvme3n1
	sleep 2

	mount -t lustre ost/ost0 /lustre/ost0
	mount -t lustre ost/ost0 /lustre/ost0
	sleep 2
	mount -t lustre ost/ost1 /lustre/ost1
	mount -t lustre ost/ost1 /lustre/ost1
	sleep 2
	mount -t lustre ost/ost2 /lustre/ost2
	mount -t lustre ost/ost2 /lustre/ost2
	sleep 2
	mount -t lustre ost/ost3 /lustre/ost3
	mount -t lustre ost/ost3 /lustre/ost3
	sleep 2
	zfs list
	df -h
fi

if [[ $1 == "oss2" ]]; then

	mkfs.lustre --ost --backfstype=zfs --index=5 --reformat --mgsnode=mds2i@o2ib --fsname=lustre ost4/ost4 /dev/nvme0n1
	sleep 2
	mkfs.lustre --ost --backfstype=zfs --index=6 --reformat --mgsnode=mds2i@o2ib --fsname=lustre ost5/ost5 /dev/nvme1n1
	sleep 2
	mkfs.lustre --ost --backfstype=zfs --index=7 --reformat --mgsnode=mds2i@o2ib --fsname=lustre ost6/ost6 /dev/nvme2n1
	sleep 2
	mkfs.lustre --ost --backfstype=zfs --index=8 --reformat --mgsnode=mds2i@o2ib --fsname=lustre ost7/ost7 /dev/nvme3n1
	sleep 2
	mount -t lustre ost4/ost4 /lustre/ost4
	mount -t lustre ost4/ost4 /lustre/ost4
	sleep 2
	mount -t lustre ost5/ost5 /lustre/ost5
	mount -t lustre ost5/ost5 /lustre/ost5
	sleep 2
	mount -t lustre ost6/ost6 /lustre/ost6
	mount -t lustre ost6/ost6 /lustre/ost6
	sleep 2
	mount -t lustre ost7/ost7 /lustre/ost7
	mount -t lustre ost7/ost7 /lustre/ost7
	sleep 2
	zfs list
	df -h
fi


if [[ $1 == "oss3" ]]; then

	mkfs.lustre --ost --backfstype=zfs --index=9 --reformat --mgsnode=mds2i@o2ib --fsname=lustre ost8/ost8 /dev/nvme0n1
	sleep 2
	mkfs.lustre --ost --backfstype=zfs --index=10 --reformat --mgsnode=mds2i@o2ib --fsname=lustre ost9/ost9 /dev/nvme1n1
	sleep 2
	mkfs.lustre --ost --backfstype=zfs --index=11 --reformat --mgsnode=mds2i@o2ib --fsname=lustre ost10/ost10 /dev/nvme2n1
	sleep 2
	mkfs.lustre --ost --backfstype=zfs --index=12 --reformat --mgsnode=mds2i@o2ib --fsname=lustre ost11/ost11 /dev/nvme3n1
	sleep 2

	mount -t lustre ost8/ost8 /lustre/ost8
	mount -t lustre ost8/ost8 /lustre/ost8
	sleep 2
	mount -t lustre ost9/ost9 /lustre/ost9
	mount -t lustre ost9/ost9 /lustre/ost9
	sleep 2
	mount -t lustre ost10/ost10 /lustre/ost10
	mount -t lustre ost10/ost10 /lustre/ost10
	sleep 2
	mount -t lustre ost11/ost11 /lustre/ost11
	mount -t lustre ost11/ost11 /lustre/ost11
	sleep 2
	zfs list
	df -h
fi

if [[ $1 == "cn" ]]; then

	mount -t lustre mds2i@o2ib:/lustre /mnt/lustre
	sleep 3
	chmod 777 /mnt/lustre
	sleep 2
	lfs df -h
fi

exit 0
