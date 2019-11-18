#!/bin/bash
for network_card in $(ls /sys/class/net/)
    do
        state=`cat /sys/class/net/$network_card/operstate`
        if [[ $state = "up" ]] 
        then
            echo  $network_card is up > /dev/null 2>&1
            up_netcards=()
            up_netcards=("${up_netcards[@]}" "$network_card") 
            echo ${up_netcards[@]}
            conn=`ip addr | grep ${up_netcards[@]} | awk '{print $2}' | cut -f1 -d'/' | sed "/${network_card}/d" | sed '/^$/d'`
            echo $conn
            
        else
            echo $network_card not up > /dev/null 2>&1
        fi
    done
public_ip=`wget --timeout=2 --tries=3 https://ipecho.net/plain -O - -q`
error=`curl -s https://ipinfo.io/$public_ip/country | grep Error | cut -f2 -d'<' | cut -f2 -d'>'`
if [[ $error != "Error" ]] 
    then
        country_id=`curl -s --connect-timeout 2.5 https://ipinfo.io/$public_ip/country`
        echo -e "$light_cyan [ * ]$white::$white[Your are Browsing The Internet From]:"$light_blue $country_id, $country_name $normal;
        echo ""
    else
    echo Error Retreving country
fi