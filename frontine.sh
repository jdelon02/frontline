#!/bin/bash

##############
# This script is my answer to the code challenge I was given.
# Convert the string:
# "(id,created,employee(id,firstname,employeeType(id), lastname),location)"
# to the following output
#
# id
# created
# employee
# - id
# - firstname
# - employeeType
# -- id
# - lastname
# location
#
##############

# This is the string that is the whole point of the exercise
frontLineString="(id,created,employee(id,firstname,employeeType(id), lastname),location)"

declare -a frontLineArray
declare -a reassembledArray

# Step 1:  Let's split the string into space delimited pieces.

frontLineString=$(echo ${frontLineString} | sed 's/(/ /g')
frontLineString=$(echo ${frontLineString} | sed 's/)/ /g')
frontLineString=$(echo ${frontLineString} | sed 's/,/ /g')

# Step 2.  Let's put the stringy bits into an array.  If I were teaching a jr.
# dev, I would want to teach them to anticipate what might be coming down the
# pike, and having the data in an array that can be easily accessed would be an
# easy win.

for l in $frontLineString; do
    frontLineArray+=(${l})
done

# Now we need to loop through and add the hyphens in the correct spots.

for l in ${!frontLineArray[@]}; do
  if [ $l = 6 ]; then
    reassembledArray+=(" -- ${frontLineArray[$l]}")
  elif [ $l = 3 ] || [ $l = 4 ] || [ $l = 5 ] || [ $l = 7 ]; then
    reassembledArray+=(" - ${frontLineArray[$l]}")
  else
    reassembledArray+=(${frontLineArray[$l]})
  fi
done

for k in "${!reassembledArray[@]}"
do
    echo ${reassembledArray["$k"]}
done

######
# This works, and gives the expected info.  It is ineligent though, and I should
# have time tomorrow to clean it up before I have to turn it in.  I think that
# creating three arrays is still the better way to do it, since then I can sort
# them before reassembly.
