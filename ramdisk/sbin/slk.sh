#!/system/bin/sh
# portions from bsmitty83, franciscofranco, ak, boype & osm0sis + Franco's Dev Team

# custom busybox installation shortcut
bb=/sbin/bb/busybox

# disable sysctl.conf to prevent ROM interference with tunables
$bb mount -o rw,remount /system;
$bb [ -e /system/etc/sysctl.conf ] && $bb mv -f /system/etc/sysctl.conf /system/etc/sysctl.conf.bak;

# create and set permissions for /system/etc/init.d if it doesn't already exist
if [ ! -e /system/etc/init.d ]; then
  mkdir /system/etc/init.d;
  chown -R root.root /system/etc/init.d;
  chmod -R 755 /system/etc/init.d;
fi;
$bb mount -o ro,remount /system;

# workaround for hung boots with nodiratime+noatime or barrier=0+data=writeback
# which occur when used as ext4 mount options for userdata via the tuna fstab
$bb [ `getprop ro.fs.data` == "ext4" ] && $bb mount -o remount,nosuid,nodev,noatime,nodiratime,barrier=0 -t auto /data;





