#!/bin/bash
while true
    do
		sleep 3
		rm -rf /tmp/odoo_projects.log
		ls ~/odoo/custom-addons/*/*.* >> /tmp/odoo_projects.log && ls ~/odoo/custom-addons/*/*/*.* >> /tmp/odoo_projects.log 
		cat /tmp/odoo_projects.log | entr -r -d odoo restart
		#ls ~/odoo/custom-addons/*/*/*.* | entr -r -d odoo restart
		#ls ~/odoo/custom-addons/*/*.* | entr -r -d odoo restart
    done

