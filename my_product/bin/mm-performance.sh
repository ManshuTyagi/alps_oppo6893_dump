#! /system/bin/sh

config="$1"

function lowram_device_setup()
{
    MemTotalStr=`cat /proc/meminfo | grep MemTotal`
    MemTotal=${MemTotalStr:16:8}

    Heapminfree=2m
    Heapmaxfree=16m
    Heapstartsize=16m
    Heapsize=512m
    Heapgrowthlimit=384m

    if [ $MemTotal -lt 6291456 ]; then
       Heapminfree=2m
       Heapmaxfree=16m
       Heapstartsize=8m
       Heapsize=512m
       Heapgrowthlimit=256m
    fi

    if [ $MemTotal -lt 4194430 ]; then
       Heapminfree=512k
       Heapstartsize=8m
       Heapsize=512m
       Heapgrowthlimit=192m
       setprop ro.config.oplus.low_ram true
    fi

    setprop dalvik.vm.heapminfree $Heapminfree
    setprop dalvik.vm.heapmaxfree $Heapmaxfree
    setprop dalvik.vm.heapstartsize $Heapstartsize
    setprop dalvik.vm.heapsize $Heapsize
    setprop dalvik.vm.heapgrowthlimit $Heapgrowthlimit
}

case "$config" in
#Haiqun.Hai@AD.Memory.Performance, 2020/12/10, add for low memory devcice
    "lowram_device_setup")
        lowram_device_setup
    ;;
       *)

      ;;
esac

