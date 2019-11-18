#!/bin/bash
UPHOSTS=/var/log/uphosts.`date +%m%d%Y`
DOWNHOSTS=/var/log/downhosts.`date +%m%d%Y`
PREFIX=192.168.2
OCTET=1
while [ $OCTET -lt 254 ];
do
    echo -en "Pinging ${PREFIX}.${OCTET} ...."
    ping -c1 -w1 ${PREFIX}.${OCTET} > /dev/null 2>&1
    if [ "$?" -eq "0" ]; then
        echo " OK"
        echo "${PREFIX}.${OCTET}" >> ${UPHOSTS}
    else
        echo  " Failed"
        echo "${PREFIX}.${OCTET}" >> ${DOWNHOSTS}
    fi
#It's could be written by this way also OCTET=$((OCTET+1))
#The Sign Dollar $ is important
    OCTET=$[OCTET+1]
done
zenity --info --text="Ping is Done" --title="Information"