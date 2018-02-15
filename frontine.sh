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


THESTRING="(id,created,employee(id,firstname,employeeType(id), lastname),location)"

# Step 1:  Let's split the string into space delimited pieces.
#
THESTRING=$(echo ${THESTRING} | sed 's/(/ /g')
THESTRING=$(echo ${THESTRING} | sed 's/)/ /g')
THESTRING=$(echo ${THESTRING} | sed 's/,/ /g')

# Step 2.  Let's put the stringy bits into an array.  If I were teaching a jr.
# dev, I would want to teach them to anticipate what might be coming down the
# pike, and having the data in an array that can be easily accessed would be an
# easy win.
declare -a THEARRAY
declare -a THENEWARRAY

for l in $THESTRING; do
    THEARRAY+=(${l})
done

# TODO: These should be split into three diff arrays, that way they could each
# be sorted separately, and then reassembled in correct order.
for l in ${!THEARRAY[@]}; do
  if [ $l = 6 ]; then
    THENEWARRAY+=(" -- ${THEARRAY[$l]}")
  elif [ $l = 3 ] || [ $l = 4 ] || [ $l = 5 ] || [ $l = 7 ]; then
    THENEWARRAY+=(" - ${THEARRAY[$l]}")
  else
    THENEWARRAY+=(${THEARRAY[$l]})
  fi
done


for k in "${!THENEWARRAY[@]}"
do
    echo ${THENEWARRAY["$k"]}
done

######
#This works, and gives the expected info.  It is ineligent though, and I should
#have time tomorrow to clean it up before I have to turn it in.  I think that
#creating three arrays is still the better way to do it, since then I can sort
#them before reassembly.



# This would be how I could handle the sort tomorrow...
#| sort -k3
