#!/bin/bash

echo "Starte rpi-vcha installer"
echo "BITTE NUR EIN MAL AUSFÜHREN"
echo "Ansonsten kommt es zu Doppeleinträgen im Crontab und /etc/modules"
echo "Paketquellen Update"
apt-get update
echo "Installiere benötigte Pakete"
apt-get install alsa-base alsa-utils libasound2-dev build-essential libttspico-data libpopt0 libpopt-dev make autoconf automake git libtool sox wget -y
echo "Installiere SphinxBase"
cd ./sphinxbase-0.8
make clean
./autogen.sh
./configure
make
make install
echo "Installiere Pico"
cd ../pico
make clean
./autogen.sh
./configure
make
make install
echo "Installiere Sphinx_listener"
cd ../sphinx_listener
make clean
./autogen.sh
./configure
make
make install
cd ..
echo "Installiere Skripte"
cp ./newsttscron.sh /usr/local/bin/newsttscron.sh
cp ./wetterttscron.sh /usr/local/bin/wetterttscron.sh
cp ./zeittts.sh /usr/local/bin/zeittts.sh
chmod +x /usr/local/bin/newsttscron.sh
chmod +x /usr/local/bin/wetterttscron.sh
chmod +x /usr/local/bin/zeittts.sh
echo "Cronjob einrichten"
echo "*/15 * * * * root /usr/local/bin/newsttscron.sh" >> /etc/crontab
echo "*/10 * * * * root /usr/local/bin/wetterttscron.sh" >> /etc/crontab
service cron restart
echo "Installiere Sprachdatenbank"
mkdir /usr/local/etc/rpi-vcha
cp ./dict.dic /usr/local/etc/rpi-vcha/dict.dic
cp ./languagemodel.lm /usr/local/etc/rpi-vcha/languagemodel.lm
echo "Modul Workaround für das Playstation Eye"
echo "options snd_usb_audio ignore_ctl_error=1" > /etc/modprobe.d/snd_usb_audio.conf
modprobe -rv snd_usb_audio
modprobe -v snd_usb_audio
echo "Modul für internen Soundchip beim Start laden"
echo "snd_bcm2835" >> /etc/modules
modprobe -v snd_bcm2835
sleep 1
amixer set PCM 100%
echo "Richte Initscript ein"
cp ./rpi-vcha /etc/init.d/rpi-vcha
update-rc.d rpi-vcha defaults

echo "Fertig"
echo "Ersetze nun in /usr/local/bin/wetterttscron.sh \"Hameln\" durch die Stadt deiner Wahl"
echo "Start mit \"service rpi-vcha start\""
echo "BITTE INSTALLER NICHT ERNEUT AUSFÜHREN"
echo "Ansonsten kommt es zu Doppeleinträgen im Crontab und /etc/modules"
echo "DAU-Shield(tm) aktiviert"
echo "Executable Bit des Installers wird entfernt"
chmod -x ./installer.sh
