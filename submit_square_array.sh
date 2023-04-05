#!/bin/bash

usage()
{
echo "submit_square_array.sh [-a account] [-t] obsnum
  -a account : user account (default = courses0100)
  -t         : test. Don't submit job, just make the batch file
               and then return the submission command
  -s         : start number
  -e         : end number" 1>&2;
exit 1;
}

pipeuser="${GPTUSER}"

#initial variables
dep=
tst=
# parse args and set options
while getopts ':ta:s:e:' OPTION
do
    case "$OPTION" in
    a)
        account=${OPTARG}
        ;;
    s)
        startnum=${OPTARG}
        ;;
    e)
	endnum=${OPTARG}
        ;;
    t)
        tst=1
        ;;
	? | : | h)
	    usage
	    ;;
  esac
done

if [[ -z $startnum || -z $endnum ]]
then
    usage
    exit 1
else
    diff=$((endnum-startnum))
    if [[ $diff -lt 0 || $diff -gt 100 || $endnum -ge 2048 ]]
    then
        echo "Must choose a range of numbers that starts low and ends high, has less than 100 between them, and the maximum is not larger than 2048."
	exit 1
    fi
fi

if [[ -z $account ]]
then
    account="courses0100"
fi

cat square_array.tmpl | sed "s/START/$startnum/" | sed "s/END/$endnum/" | sed "s/ACCOUNT/$account/" > sbatch_square_array.sh

if [[ ! -z $tst ]]
then
    sbatch sbatch_square_array.sh
else
    echo "Have a look at sbatch_square_array.sh ."
fi

