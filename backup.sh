#!/bin/bash
BACKUPDIR=backup
NOW=$(date +%Y-%m-%d_%H:%M:%S)

if [ ! -d "$BACKUPDIR" ]; then
  /bin/mkdir $BACKUPDIR
fi

while read srcdir dstdir
do
    if [ "$src" == "#" ]; then
        continue 2
    fi

    if [ ! -d "$BACKUPDIR/$dstdir" ]; then
        /bin/mkdir $BACKUPDIR/$dstdir
    fi
    /usr/bin/rsync -av --delete $srcdir $BACKUPDIR/$dstdir

done < backup.conf

/usr/bin/git add .
/usr/bin/git commit -v -m "Backup $NOW"
/usr/bin/git push origin master
