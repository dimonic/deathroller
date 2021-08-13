#!/bin/bash

success=0
failure=0
successes=0
failures=0

for i in {1..10000..1}
do
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
echo "      failures:  $failures"   
unresolved=$(( 10000 - $successes - $failures ))
echo "Unresolved:      $unresolved"
echo "Prob. survival: $(( ($successes + $unresolved) * 100 / 10000 ))"
