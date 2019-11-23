#!/bin/bash
case $1 in
    start) echo "terminal123" | sudo -S service odoo11 start
    ;;
    stop) echo "terminal123" | sudo -S service odoo11 stop
    ;;
    restart) echo "terminal123" | sudo -S service odoo11 restart
    ;;
    status) echo "terminal123" | sudo -S service odoo11 status
    ;;
    *) echo "Usages odoo [ start | restart | stop | status ]"
esac
