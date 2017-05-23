#!/bin/bash
# The purpose of this script is to dynamically backup LVM disks
# by utilizing lvm snapshot feature, and creating a tar.gz of the 
# LVM snapshot.

# lvcreate -L1G -s -n /dev/vm00/git00.internal.matthassel.com-snapshot /dev/vm00/git00.internal.matthassel.com
#dd if=/dev/virtual-machines/backup-tests bs=512K | gzip -9 > <backup file name>
FILENAME=$(basename "$0")
LVM_PATH="/dev/vg00"
LVM_SNAPSHOT_SIZE=3
BACKUP_PATH="/backup"
#BACKUP_LOG="/var/log/${FILENAME%.*}.log"
error="false"

for lv in `ls ${LVM_PATH} | grep -v snapshot`; do
	lv_device="${LVM_PATH}/${lv}"
	lv_snapshot="${lv_device}-snapshot"
	lv_date="`date +%m%d%d`"
	lv_backup="${BACKUP_PATH}/${lv}.${lv_date}.gz"

	echo $lv_device,$lv_snapshot,$lv_date,$lv_backup

	if [[ ! -b ${lv_device} ]]; then
		echo "Block device, ${lv_device}, does not exist"
		error="true"
	else
		echo "Block device, ${lv_device}, found... creating snapshot"
	fi

	# Do quick checkto see if snapshot already exists
	/sbin/lvdisplay ${lv_snapshot} > /dev/null 2>&1
	if [[ $? -ne 0 ]]; then
		/sbin/lvcreate -L${LVM_SNAPSHOT_SIZE}G -s -n ${lv_snapshot} ${lv_device} > /dev/null 2>&1
	else
		echo "LV snapshot, ${lv_snapshot}, already exists..."
		error="true"
		continue
	fi

	# Create backup of snapshot volume
	echo "Starting backup of ${lv_snapshot} to ${BACKUP_PATH}/${lv}.gz"
	/bin/dd if=${lv_snapshot} bs=512K | /bin/gzip -9 > ${lv_backup}
	echo "Backup Complete"
	echo "Removing Snapshot"
	/sbin/lvremove ${lv_snapshot} --force
done

if [[ "$error" == "true" ]]; then
	echo "Errors have occured, please review and take action accordingly."
	exit 1
else
	:
fi
