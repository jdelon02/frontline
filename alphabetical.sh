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
FrontLineString="(id,created,employee(id,firstname,employeeType(id), lastname),location)"

# Let's Declare some arrays...
declare -a FrontLineArray
declare -a FirstArray
declare -a SecondArray
declare -a ThirdArray
declare -a ReassembledArray

# Step 1:  Let's split the string into space delimited pieces.
#
FrontLineString=$(echo ${FrontLineString} | sed 's/(/ /g')
FrontLineString=$(echo ${FrontLineString} | sed 's/)/ /g')
FrontLineString=$(echo ${FrontLineString} | sed 's/,/ /g')

# Step 2.  Let's put the stringy bits into an array.
for l in $FrontLineString; do
    FrontLineArray+=(${l})
done

# TODO: These should be split into three diff arrays, that way they could each
# be sorted separately, and then reassembled in correct order.
for l in ${!FrontLineArray[@]}; do
  if [ $l = 6 ]; then
    ThirdArray+=(${FrontLineArray[$l]})
  elif [ $l = 3 ] || [ $l = 4 ] || [ $l = 5 ] || [ $l = 7 ]; then
    SecondArray+=(${FrontLineArray[$l]})
  else
    FirstArray+=(${FrontLineArray[$l]})
  fi
done

SecondArray=($(for each in ${SecondArray[@]}; do echo $each; done | sort))
echo ${SecondArray[@]}

FirstArray=($(for each in ${FirstArray[@]}; do echo $each; done | sort))
echo ${FirstArray[@]}



######
#This works, and gives the expected info.  It is ineligent though, and I should
#have time tomorrow to clean it up before I have to turn it in.  I think that
#creating three arrays is still the better way to do it, since then I can sort
#them before reassembly.
