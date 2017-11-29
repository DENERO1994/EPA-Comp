#!/bin/bash

minNum=1	#variables to store minimum and maximum values 
maxNum=50

if [ $1 -lt $minNum ] || [ $1 -gt $maxNum ]; then		#If statement to check that the user input is in the correct range
 echo "parameter is outside of the range - please enter a number between $minNum and $maxNum"
else
 for ((i = $minNum; i <= $1; i++)); do
  ./loadtest $i
  mpstat 5 1
 done
fi
