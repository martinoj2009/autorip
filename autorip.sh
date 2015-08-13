#! /bin/bash
# Wait for a CD to be inserted then copy the contents
# Martino Jones
# 20150701
#
echo "CD copy, press <ctrl>C to exit"
echo "Looking for disk..."
#
# Go into a continuous loop always looking for a new CD
while :
    do
####### Get the mount point of /dev/sr0 out of the mounts file       
        TEST=$(blkid -o value -s LABEL /dev/sr0)
####### If it doesn't exist, loop until it does with 1 second pause
        if [ "$TEST" == "" ]; then
                sleep 1
        else
                echo
############### Got it!  Need to strip the mount point out of the string
        echo "Got IT!"
                TEST2=${TEST:9}
                set $TEST2
                TEST=$1
############### Do the copy process for the disk we found
                echo "Copying from $TEST"
                HandBrakeCLI -f mkv -N swe -m -i /dev/sr0 -o /external/movies/$(blkid -o value -s LABEL /dev/sr0).mkv -e ffmpeg -b 2000 -B 192 --main-feature
############### Eject the CD with suitable pauses to avoid any buffer problems
                sleep 1
                eject cdrom
                sleep 2
        fi
######## Still looping! Go back and wait for another CD!
    done
exit()