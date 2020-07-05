#!/bin/sh

case $1 in
	up)
		echo "$(( $(< /sys/class/backlight/acpi_video0/brightness) + 1))" > /sys/class/backlight/acpi_video0/brightness
	;;
	down)
		echo "$(( $(< /sys/class/backlight/acpi_video0/brightness) - 1))" > /sys/class/backlight/acpi_video0/brightness
	;;
esac
