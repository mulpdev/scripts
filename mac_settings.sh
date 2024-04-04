#!/bin/sh

Help()
{
  echo "Usage: $0 <command> [value]"
  echo "<command> list:"
  echo "\t-b|-backlight <value>: Show current backlight value or sets backlight to <value> if supplied"
  echo "\t-s|-scale <value>: set scale to value on laptop display. Default value is 0.70"
}

Backlight()
{
  value=$1
  if [ -z ${value} ]; then
    cat /sys/class/backlight/gmux_backlight/brightness
  else
    sudo sh -c "echo $value > /sys/class/backlight/gmux_backlight/brightness"
  fi
}

Scale()
{
  value=$1
  if [ -z ${value} ]; then
    echo "Scale value must be supplied as float (e.g., default is 0.70)"
  else
    xrandr --output eDP-1 --scale ${value}x${value}
    if [ $? -ne 0 ]; then
      echo "xrandr --output eDP-1 --scale ${value}x${value}"
      echo "Something broke. Rerun script (or xrandr manually) with different scales until it succeeds, then try desired scale again"
    fi
  fi
}
while :; do
  case $1 in
    -b|-backlight)
      shift
      Backlight $@
      exit ;;
    -s|-scale)
      shift
      Scale $@
      exit ;;
    -h|--help|-\?)
      Help
      exit ;;
    *)
      Help
      break
  esac
  shift
done
