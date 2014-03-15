#!/bin/bash
message="Die aktuellen Schlagzeilen: "

speak() {
pico2wave -l=de-DE -w=/dev/shm/newstts.wav "$1"
sox /dev/shm/newstts.wav -c 2 /dev/shm/newsttssox.wav gain -12 treble +16
}

schlagzeilen() {

schlagzeilen=`wget --timeout=10 -qO -  "https://news.google.com/news/feeds?hl=de&output=rss&gcs=hannover&hdlOnly=1" | grep -oPm1 "(?<=<title>)[^<]+" | grep -v "Google News: Schlagzeilen" | sed 's/ - /=/g' | cut -d"=" -f1 | tr "\n" "=" | sed -e 's/=/. STOPP .  /g' -e 's/+++//g' -e 's/ \.\.\.\. / \. /g' -e 's/&quot;//g'`

message+="$schlagzeilen  ENDE der Übertragung"

}
schlagzeilen
speak "$message"
