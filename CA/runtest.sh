#!/bin/bash

minNum=1	#variables to store minimum, maximum values and the duration of the test
maxNum=50
duration=5

if [ $1 -lt $minNum ] || [ $1 -gt $maxNum ]; then		#If statement to check that the user input is in the correct range
 echo "parameter is outside of the range - please enter a number between $minNum and $maxNum"
else
 for ((i = $minNum; i <= $1; i++)); do
  ./loadtest $i &
  mpstat $duration 1 -o JSON | jq '.sysstat.hosts[0].statistics[0]."cpu-load"[0].idle'
  pkill loadtest
 done
fi
