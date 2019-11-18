#!/bin/bash

######################

#Color Schemas
pass="terminal123"
light_red='\e[1;31m'
yellow='\e[1;33m'
brown='\e[0;33m'
light_cyan='\e[1;36m'
light_green='\e[1;32m'
normal='\e[0m'
shadow_color='\e[31;43m'

###########################


echo -e "\t~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n"
echo -e "\t   Simple System Diagnostic Tool "| figlet -c
echo -e "\t~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n"
echo -e " $yellow[*]$normal Choose one of the following options"
echo ""
echo -e "\t$light_cyan[1]$normal Show boot Time"
echo -e "\t$light_cyan[2]$normal Show boot Digram"
echo -e "\t$light_cyan[3]$normal Show Systemd status"
echo -e "\t$light_cyan[4]$normal List Systemd Failed Services"
echo -e "\t$light_cyan[5]$normal List Systemd Running Jobs"
echo -e "\t$light_cyan[6]$normal Check The System Journal"
echo -e "\t$light_cyan[7]$normal Free Space From The System Journal"
echo -e "\t$light_cyan[8]$normal Check The Kernel Messages\n"
echo -en " $yellow[*]$normal Enter The Number of Selected Option: "
read  var
echo " "

if [[ -n $var && $[var] != $var ]]
    then
        echo -e "$light_red\"$var\" is Not an Option!$normal"
elif [ -z $var ] 
    then
        echo -e "$light_red Wrong choice $brown[Please Select one of the Options 1 ~ 8]$normal"
elif [ $var -eq 1 ] 
    then
        echo -e "$shadow_color***** Showing Boot Time *****$normal\n"
        sleep 1
        systemd-analyze
        echo " "
elif [ $var -eq 2 ] 
    then
        echo -e "$shadow_color***** Creating boot.svg file *****$normal\n"
        #echo "Creating boot.svg file"
        sleep 2
        systemd-analyze plot > /home/$USER/boot.svg 
        echo -e "$light_cyan[!]$brown Starting Browser To view the Digram$normal"
        sleep 2 ;
        x-www-browser ~/boot.svg
        echo -e "$light_cyan[!]$brown Removing boot.svg$normal"
        sleep 2
        rm -rf ~/boot.svg
        echo " "
elif [ $var -eq 3 ]
    then
        echo -e "$shadow_color***** Showing Systemd Status *****$normal"
        #echo "Showing Systemd Status"
        sleep 2
        systemctl status
        echo " "
elif [ $var -eq 4 ]
    then
        echo -e "$shadow_color***** Showing Systemd Failed Serivces *****$normal"
        #echo "Showing Systemd Failed Serivces"
        echo " "
        sleep 2
        systemctl list-units --failed
        echo " "
elif [ $var -eq 5 ]
    then
        echo -e "$shadow_color***** Showing Systemd Running Jobs *****$normal\n"
        #echo "Showing Systemd Running Jobs"
        echo " "
        sleep 2
        systemctl list-jobs
        echo " "
elif [ $var -eq 6 ]
    then
        echo -e "$shadow_color***** Checking The System Journal *****$normal\n"
        #echo "Checking The System Journal"
        echo " "
        sleep 2
        journalctl -xe
        echo " "
elif [ $var -eq 7 ]
    then
        echo -e "$shadow_color***** Freeing Some space *****$normal"
        #echo "Freeing Some space"
        echo " "
        sleep 2
        if [ $UID != 0 ]
            then
                echo -e "$light_red[!]$normal$brown You Need root Perminssions$normal \n"
                echo -en "$light_green Enter The sudo command: $normal"
                read  s
                echo $pass | $s -S journalctl --vacuum-time=1d
        fi
        echo " "
elif [ $var -eq 8 ]
    then
        echo -e "$shadow_color***** Showing The Kernel Messages *****$normal\n"
        #echo -e "Showing The Kernel Messages"
        sleep 1
        dmesg -H
else
        echo " "
        echo -e "$light_red Please Choose From Above Options$normal"
fi
