#!/bin/bash

##############
# This script is my answer to the code challenge I was given.  This is version 2
# Convert the string:
# "(id,created,employee(id,firstname,employeeType(id), lastname),location)"
# to the following output
#
# Bonus (output in alphabetical order):
# created
# employee
# - employeeType
# -- id
# - firstname
# - id
# - lastname
# id
# location
##############

# This is the string that is the whole point of the exercise
frontLineString="(id,created,employee(id,firstname,employeeType(id), lastname),location)"

# Let's Declare some arrays...
declare -a frontLineArray
declare -a firstArray
declare -a secondArray
declare -a thirdArray
declare -a reassembledArray

# Step 1:  Let's split the string into space delimited pieces.
#
frontLineString=$(echo ${frontLineString} | sed 's/(/ /g')
frontLineString=$(echo ${frontLineString} | sed 's/)/ /g')
frontLineString=$(echo ${frontLineString} | sed 's/,/ /g')

# Step 2.  Let's put the stringy bits into an array.
for l in $frontLineString; do
    frontLineArray+=(${l})
done

# TODO: These should be split into three diff arrays, that way they could each
# be sorted separately, and then reassembled in correct order. - DONE
for each in ${!frontLineArray[@]}; do
  if [ $each = 6 ]; then
    thirdArray+=(" -- ${frontLineArray[$each]}")
  elif [ $each = 3 ] || [ $each = 4 ] || [ $each = 5 ] || [ $each = 7 ]; then
    secondArray+=(${frontLineArray[$each]})
  else
    firstArray+=(${frontLineArray[$each]})
  fi
done

# I want to output the arrays back into themselves in sorted order.  Don't need
# to do this for the third, since that is an array of one.
secondArray=($(for each in ${secondArray[@]}; do echo $each; done | sort))
firstArray=($(for each in ${firstArray[@]}; do echo $each; done | sort))

# Now I need to add the - to the front of the secondArray elements. I did this
# as a second step, since the sort was breaking on the '-'.
for each in "${!secondArray[@]}"
do
  secondArray[${each}]=" - ${secondArray[each]}"
done

# @TODO: THERE HAS TO BE A BETTER WAY!  I have been struggling with this, but I
# don't want the solution to take 3x more code than the problem.  I wanted to
# merge the arrays, inserting the arrays in a way that would allow to pop, but I
# couldn't get it to work the way I wanted it to.  This displays in alphabetical
# order, but oy vay...

reassembledArray[0]=${firstArray[0]}
reassembledArray[1]=${firstArray[1]}
reassembledArray[2]=${secondArray[0]}
reassembledArray[3]=${thirdArray[0]}
reassembledArray[4]=${secondArray[1]}
reassembledArray[5]=${secondArray[2]}
reassembledArray[6]=${secondArray[3]}
reassembledArray[7]=${firstArray[2]}
reassembledArray[8]=${firstArray[3]}

for each in "${!reassembledArray[@]}"
do
  echo ${reassembledArray["$each"]}
done
