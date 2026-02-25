#!/bin/bash

echo "====AUTUMATED BACKUP SCRIPT===="
echo ""


read -p "enter the directory to backup:" SOCC

if [ ! -d "$SOCC" ]; then
	echo "Error: Source directory does not exists!"
	exit 1
fi

read -p "enter bacjup destination :" DEST
mkdir -p "$DEST"


echo ""
echo "Backup type:"
echo "1. Simple copy"
echo "2. compressed archive (tar.gz)"
read -p "enter the choice:" choice

timess=$(date +%Y%m%d%H%M%S)


start=$(date +%s)


case $choice in
	1)
		bk_nm="backup _$timess"
		cp -r "$SOCC" "$DEST/$bk_nm"
		;;
	2)
		bk_nm="backup _$timess.tar.gz"
		tar -czf "$DEST/$bk_nm" "$SOCC"
		;;
	*)
		echo "invalid choice!"
		exit 1
esac

END=$(date +%s)
duration=$((END-start))


if [ $? -eq 0 ]; then
	echo ""
	echo "Backup completed successfully!"
else
	echo "backup failed!"
	exit 1
fi

size=$(du -sh "$DEST/$bk_nm" 2>/dev/null | awk '{print $1}')


echo ""
echo "Backup details:"
echo "File: $bk_nm"
echo "Location: $DEST"
echo "Size: $size"
echo "Time Taken: $duration seconds"


LOGFILE="$DEST/backup.log"

echo "[$(date)] Backup: $bk_nm | Size: $size | Time: $duration sec" >> "$LOGFILE"


cd "$DEST" || exit
ls -t backup_* 2>/dev/null | tail -n +6 | while read file
do
	rm -f "$file"
done


echo "Backup Process completed"
