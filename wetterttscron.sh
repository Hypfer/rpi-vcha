#!/bin/bash
message=""

speak() {
pico2wave -l=de-DE -w=/dev/shm/wettertts.wav "$1"
sox /dev/shm/wettertts.wav -c 2 /dev/shm/wetterttssox.wav gain -12 treble +16
}

wetter() {

jsonwetter=`wget --timeout=10 -qO - "http://api.openweathermap.org/data/2.5/weather?q=Hameln,Germany&lang=de&units=metric"`
wetter=`echo $jsonwetter | cut -d":" -f13 | cut -d"," -f1 | sed -e 's/\"//g'`
tempdraussen=`echo $jsonwetter | cut -d":" -f17 | cut -d"," -f1 | tr "." ","`


if [ -z "$wetter" ]; then
	wetter="Unbekannt"
fi
if [ -z "$tempdraussen" ]; then
	tempdraussen="Unbekannt"
fi

message+="$wetter bei $tempdraussen Grad. "

}
wetter
speak "$message"
