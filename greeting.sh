#!/bin/bash
h=`date +%H`
if [ $h -lt 12 ]; then
  espeak -v en "Good morning Mohamed."
elif [ $h -lt 18 ]; then
  espeak -v en "Good afternoon Mohamed."
else
  espeak -v en "Good Evening Mohamed."
fi
