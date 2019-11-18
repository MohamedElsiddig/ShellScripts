#!/bin/bash
read X
if [[ "$X" = "N" || $X = "n" ]]
then 
echo "NO"
elif [[ $X = "Y" || $X = "y" ]]
then
    echo "YES"
fi
