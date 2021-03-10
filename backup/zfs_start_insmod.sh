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

#insmod /lib/modules/3.10.0-1062.1.1.el7_myms.x86_64/extra/zfs/zfs/zfs.ko zio_taskq_batch_pct=5  #1 5 10 20 50

#insmod /lib/modules/3.10.0-1062.1.1.el7_myms.x86_64/extra/zfs/zfs/zfs.ko zfs_dbgmsg_enable=0 zio_taskq_batch_pct=75 zfs_vdev_sync_write_max_active=16 zfs_vdev_async_write_max_active=16

#insmod /lib/modules/3.10.0-1062.1.1.el7_myms.x86_64/extra/zfs/zfs/zfs.ko zio_taskq_batch_pct=75 zfs_dbgmsg_enable=1 zio_nactive=24 zio_ctxt=1000
#insmod /lib/modules/3.10.0-1062.1.1.el7_myms.x86_64/extra/zfs/zfs/zfs.ko zio_opt=1 zio_nactive=12 zio_ctxt=2000 zfs_dbgmsg_enable=1

#insmod /lib/modules/3.10.0-1062.1.1.el7_myms.x86_64/extra/zfs/zfs/zfs.ko zio_taskq_batch_pct=$1 zio_opt=$2 zio_nactive=$3 zio_ctxt=$4 zfs_dbgmsg_enable=$5
insmod /lib/modules/3.10.0-1062.1.1.el7_myms.x86_64/extra/zfs/zfs/zfs.ko zio_taskq_batch_pct=75 zio_opt=1 zio_nactive=0 zio_ctxt=0 zfs_dbgmsg_enable=0
#zio_sync_taskq_batch_pct=5
#zio_dirty_data_sync=4209588428



