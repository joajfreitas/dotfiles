#!/usr/bin/env python

import os, subprocess, time
import gi

gi.require_version('Notify', '0.7')
from gi.repository import Notify

battery_dir = "/sys/class/power_supply/BAT1"
battery_level_dir = os.path.join(battery_dir, "capacity")
battery_state_dir = os.path.join(battery_dir, "status")

while True:

    notify = ""
    urgency = 0
    Notify.init("hello_world")

    if os.path.exists(battery_dir):
        print("battery detected")
        level_file = open(battery_level_dir)
        state_file = open(battery_state_dir)
        battery_level = int(level_file.read())
        battery_state = state_file.read()
        battery_state = battery_state.rstrip('\n')
        print("battery: ", battery_level)

        #if battery_level % 10 == 0 and battery_level < 100:
        #    notify = battery_state + ": " + str(battery_level) + "%"
        #    urgency = 1
        if not "Charging" in battery_state and battery_level <= 15:
            if battery_level <= 15 and battery_level > 10:
                notify = "Low battery. Please charge your computer."
            elif (battery_level <= 10 and battery_level > 5):
                notify = "Low battery. Suspending"
                os.system("sudo pm-suspend")
            else:
                notify = "Low battery. Shutting down"
                os.system("poweroff")


            urgency = 2
        level_file.close()
        state_file.close()

    notification = Notify.Notification.new(notify)
    notification.set_urgency(urgency)
    if (notify != ""):
        notification.show()
    Notify.uninit()
    time.sleep(60)
