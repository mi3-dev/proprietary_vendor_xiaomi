#!/system/bin/sh

PATH=/system/bin
export PATH

if [ $(getprop ro.boot.hwversion | grep -e 5[0-9]) ]; then
    /system/bin/log -p e -t "SensorSelect" "Device is X5, set HAL to st_mve"

    # help the sensorservice to load the correct HAL
    setprop ro.hardware.sensors st_mve

    # delay sensorservice to wait for hardware being ready
    setprop system_init.startsensorservice 0
fi
