#!/usr/bin/env bash

# Make an input.txt made of a bunch of numbers

if [[ ! -e input.txt ]]
then
    for i in {102809..109092}
    do
        echo $i >> input.txt
    done
fi

# Make a script that squares each number

# From pipe
#echo 'while read x ; do echo $((x * x)) ; done' > square2.sh

# As an argument
echo 'n=$1; echo $((n * n))' > square.sh
chmod +x square.sh

# See how long that takes without parallelisation

time xargs -P1 -n1 -a input.txt ./square.sh > output.txt

# And with:

time xargs -P4 -n1 -a input.txt ./square.sh > output.txt


