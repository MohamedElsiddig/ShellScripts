#!/bin/bash

### Set initial time of file
LTIME=`stat -c %Z connection`
pass="terminal123"
while true    
do
   ATIME=`stat -c %Z connection`

   if [[ "$ATIME" != "$LTIME" ]]
   then    
       cp -rf connection ~/Documents/Shell\ Scripts/connection
       echo $pass | sudo -S cp -rf connection /usr/bin/connection
       echo $pass | sudo -S cp -rf connection /media/mohamedelsiddig/f38acdd8-b50b-403e-9d83-60942fa0f707/home/mohamedelsiddig/Documents/Shell\ Scripts/connection
       echo $pass | sudo -S cp -rf connection /media/mohamedelsiddig/f38acdd8-b50b-403e-9d83-60942fa0f707/usr/bin/connection
       LTIME=$ATIME
   fi
   sleep 3
done

