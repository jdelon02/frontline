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

# Step 2.  Let's put the string bits into an array.  If I were teaching a jr.
# dev, I would want to teach them to anticipate what might be coming down the
# pike, and having the data in an array that can be easily accessed would be an
# easy win.
declare -a THEARRAY
for l in $THESTRING; do
       THEARRAY+=($l)
done

## Saved for later

for k in "${!THEARRAY[@]}"
do
    echo $k ' - ' ${THEARRAY["$k"]}
done
# |
# sort -rn -k3
