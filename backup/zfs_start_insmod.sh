#!/bin/bash

insmod /lib/modules/3.10.0-1062.1.1.el7_myms.x86_64/extra/lustre/net/libcfs.ko 
insmod /lib/modules/3.10.0-1062.1.1.el7_myms.x86_64/extra/lustre/net/lnet.ko 
insmod /lib/modules/3.10.0-1062.1.1.el7_myms.x86_64/extra/lustre/fs/obdclass.ko 
#insmod /lib/modules/3.10.0-1062.1.1.el7_myms.x86_64/extra/lustre/fs/ptlrpc.ko ptlrpcd_per_cpt_max=1
insmod /lib/modules/3.10.0-1062.1.1.el7_myms.x86_64/extra/lustre/fs/ptlrpc.ko
insmod /lib/modules/3.10.0-1062.1.1.el7_myms.x86_64/extra/lustre/fs/fld.ko 
insmod /lib/modules/3.10.0-1062.1.1.el7_myms.x86_64/extra/lustre/fs/fid.ko 
insmod /lib/modules/3.10.0-1062.1.1.el7_myms.x86_64/extra/lustre/fs/lov.ko 
insmod /lib/modules/3.10.0-1062.1.1.el7_myms.x86_64/extra/lustre/fs/osc.ko 
insmod /lib/modules/3.10.0-1062.1.1.el7_myms.x86_64/extra/lustre/fs/mdc.ko 
insmod /lib/modules/3.10.0-1062.1.1.el7_myms.x86_64/extra/lustre/fs/lmv.ko 
insmod /lib/modules/3.10.0-1062.1.1.el7_myms.x86_64/extra/lustre/fs/lustre.ko 

insmod /lib/modules/3.10.0-1062.1.1.el7_myms.x86_64/extra/spl/spl/spl.ko 
insmod /lib/modules/3.10.0-1062.1.1.el7_myms.x86_64/extra/zfs/nvpair/znvpair.ko 
insmod /lib/modules/3.10.0-1062.1.1.el7_myms.x86_64/extra/zfs/zcommon/zcommon.ko 
insmod /lib/modules/3.10.0-1062.1.1.el7_myms.x86_64/extra/zfs/icp/icp.ko 
insmod /lib/modules/3.10.0-1062.1.1.el7_myms.x86_64/extra/zfs/avl/zavl.ko 
insmod /lib/modules/3.10.0-1062.1.1.el7_myms.x86_64/extra/zfs/unicode/zunicode.ko 
#insmod /lib/modules/3.10.0-1062.1.1.el7_myms.x86_64/extra/zfs/zfs/zfs.ko zvol_threads=1 zfs_vdev_aggregation_limit=1048576 zfs_vdev_async_write_active_min_dirty_percent=20 zfs_vdev_async_write_min_active=5 zfs_vdev_async_write_max_active=10 zfs_vdev_sync_read_min_active=16 zfs_vdev_sync_read_max_active=16
insmod /lib/modules/3.10.0-1062.1.1.el7_myms.x86_64/extra/zfs/zfs/zfs.ko zio_taskq_batch_pct=10
