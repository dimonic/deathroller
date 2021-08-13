#!/bin/bash

success=0
failure=0
successes=0
failures=0
tot_rolls=10000

i=1
while [ $i -lt $tot_rolls ]
do
  i=$((i + 1))
  for c in {0..3..1}
  #while true
  do
    roll=$(( (${RANDOM} * 20 / 32768) + 1 ))
    echo "Roll = $roll"
    if  [ $roll -eq 1 ]
    then
      failure=$(( $failure + 2 ))
    elif [ $roll -lt 10 ]
    then
     failure=$(( $failure + 1 )) 
    elif [ $roll -eq 20 ] 
    then
      success=3
    else
      success=$(( $success + 1 ))
    fi
    if [ $failure -ge 3 ]
    then
      echo "You died"
      failure=0
      failures=$(( $failures + 1 ))
      break
    elif [ $success -ge 3 ]
    then
      echo "You recovered"
      success=0
      successes=$(( $successes + 1 ))
      break
    fi
  done
done

echo "Total successes: $successes"
echo "       failures: $failures"   
unresolved=$(( $tot_rolls - $successes - $failures ))
echo "     Unresolved: $unresolved"

recovered=`bc <<HERE
scale=2
$successes * 100 / $tot_rolls
HERE`

survived=`bc <<HERE
scale=2
($successes + $unresolved) * 100 / $tot_rolls
HERE`

died=`bc <<HERE
scale=2
$failures * 100 / $tot_rolls
HERE`

echo "Recovered:       ${recovered}"
echo "Prob. survival:  ${survived}"
echo "Prob. death:     ${died}"
