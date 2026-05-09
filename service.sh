#!/system/bin/sh
until [ "$(getprop sys.boot_completed)" -eq 1 ]; do sleep 5; done
sleep 0.1

sync && echo 3 > /proc/sys/vm/drop_caches

sh /data/adb/modules/ZramTG24/ram.sh &