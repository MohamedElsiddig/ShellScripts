#!/bin/bash
read x
read y
read z
# EQUILATERAL متساوي الاضلاع 
#ISOSCELES متساوي الساقين
#SCALENE مختلف الاضلاع
if [[ $x -eq $y && $x -eq $z ]] 
then
    echo "EQUILATERAL"
elif [[ $y -eq $z || $y -eq $x ]]
    then 
    echo "ISOSCELES"
else
    echo "SCALENE"
fi
