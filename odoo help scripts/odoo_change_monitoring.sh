#!/bin/bash

### Set initial time of file
LTIME=`stat -c %Z /home/mohamedelsiddig/odoo/custom-addons/`
pass="terminal123"
while true    
do
   ATIME=`stat -c %Z /home/mohamedelsiddig/odoo/custom-addons/`

   if [[ "$ATIME" != "$LTIME" ]]
   then    
       echo "$pass" | sudo -S service autoRestart_odoo_server.sh restart
       LTIME=$ATIME
   fi
   sleep 3
done

