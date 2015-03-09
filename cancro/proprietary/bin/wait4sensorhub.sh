#!/system/bin/sh

if [ $(getprop ro.boot.hwversion | grep -e 5[0-9]) ]; then
    /system/bin/log -p e -t "SensorSelect" "Device is X5, wait4sensorhub"

    HID=/sys/bus/hid/drivers/hid-sensor-hub/0018:0483:5702.0001

    cnt=0
    while [ $cnt -lt 20 ]; do
        if [ -e ${HID} ]; then
            break
        fi
        ((cnt += 1))
        sleep 1
    done

    if [ $cnt -eq 20 ]; then
        /system/bin/log -p e -t "SensorSelect" "sensorhub error: HW is absent"
    else
        /system/bin/log -p e -t "SensorSelect" "sensorhub HW is ready now, start sensorservice"
    fi

    # always start sensorservice, otherwise the system may hang in powerup
    start sensorservice
    start sensorext
else
    /system/bin/log -p e -t "SensorSelect" "Device is not X5, skip wait"
fi
