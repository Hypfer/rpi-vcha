#!/bin/bash
message=""

speak() {
pico2wave -l=de-DE -w=/dev/shm/zeittts.wav "$1"
sox /dev/shm/zeittts.wav -c 2 /dev/shm/zeitttssox.wav gain -12 treble +16
aplay /dev/shm/zeitttssox.wav 2>1 > /dev/null
rm -rf /dev/shm/zeittts.wav 2>1 > /dev/null
rm -rf /dev/shm/zeitttsox.wav 2>1 > /dev/null
}

zeit() {

zeitdatum=`date +"%H:%M Am %A den %d.%m.%Y"`

message+="$zeitdatum"

}
zeit
speak "$message"
