#!/bin/bash

#variables to store minimum, maximum values and the duration of the test
min_num=1
max_num=50
duration=5

#Column headings for the results file
echo -e "C0 \t N \t idle" > results.dat

#If statement to check that the user input is in the correct range, if not display error message
#If it is then continue with script
if [ $1 -lt $min_num ] || [ $1 -gt $max_num ]; then
 echo "parameter is outside of the range - please enter a number between $min_num and $max_num"
else
#For loop to run the load test N times, where N=Number of users passed as a parameter
 for ((i=$min_num; i<=$1; i++)); do
  #run the loadtest script in the background (so can be killed by command pkill)
  ./loadtest $i &
  
  #command that gets the idle time by parsing the JSON result with jq to retrive the specific
  #information and stores in variable called idle
  idle=$(mpstat $duration 1 -o JSON | jq '.sysstat.hosts[0].statistics[0]."cpu-load"[0].idle')
 
 #gets the line count from the synthetic.dat file to count the number of transactions (C0) and stores
  #in a variable called transactions
  transactions=$(cat synthetic.dat | wc -l)

  #Adds the transactions, number of users and idle time to the results.dat file
  echo -e "$transactions \t $i \t $idle" >> results.dat
  
  #Kills the loadtest script
  pkill loadtest
 done
fi
