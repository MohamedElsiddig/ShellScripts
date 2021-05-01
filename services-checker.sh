#!/bin/bash
#ver. 4
##this script will check mysql and apache
##if that service is not running
##it will start the service and send an email to you
##if the restart does not work, it sends an email and then exits
##set the path ##this works for Ubuntu 14.04 and 16.04
PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin
#set -x
##set your email address 
#EMAIL="webmaster@mail.com"
EMAIL="reciver-email@mail.com"
##list your services you want to check
SERVICES=( 'smb' 'nextcloud@nextcloud' )

#### OK. STOP EDITING ####


 for i in "${SERVICES[@]}"
  do
 ###CHECK SERVICE####
 $(pgrep $i >/dev/null 2>&1)
 STATS="$?"

 ###IF SERVICE IS NOT RUNNING####
 if [[  $STATS == 1  ]]

  then
  ##TRY TO RESTART THAT SERVICE###
  systemctl start $i 

  ##CHECK IF RESTART WORKED###
  `pgrep $i >/dev/null 2>&1`
  RESTART="$?"

  if [[  $RESTART == 0  ]]
   ##IF SERVICE HAS BEEN RESTARTED###
   then

    ##REMOVE THE TMP FILE IF EXISTS###
    if [ -f "/tmp/$i" ]; 
    then
     rm /tmp/$i
    fi

    ##SEND AN EMAIL###
    MESSAGE="$i was down, but I was able to restart it on $(hostname) $(date)  "
    SUBJECT="$i was down -but restarted-  on $(hostname) $(date) "
    echo $MESSAGE | mail  -s "$SUBJECT" "$EMAIL" >/dev/null 2>&1

   else
    ##IF RESTART DID NOT WORK###

    ##CHECK IF THERE IS NOT A TMP FILE###
    if [ ! -f "/tmp/$i" ]; then

     ##CREATE A TMP FILE###
     touch /tmp/$i

     ##SEND A DIFFERENT EMAIL###
     MESSAGE="$i is down on $(hostname)  at $(date)  "
     SUBJECT=" $i  down on $(hostname) $(date) "
     echo $MESSAGE  " I tried to restart it, but it did not work"  | mail -s "$SUBJECT" "$EMAIL" >/dev/null 2>&1
    fi
  fi
 fi



  done
exit 0;
