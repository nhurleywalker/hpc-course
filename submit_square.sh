#!/bin/bash

usage()
{
echo "submit_square.sh [-a account] [-t] obsnum
  -a account : user account (default = courses0100)
  -t         : test. Don't submit job, just make the batch file
               and then return the submission command
  number     : the number to process." 1>&2;
exit 1;
}

pipeuser="${GPTUSER}"

#initial variables
dep=
tst=
# parse args and set options
while getopts ':ta:' OPTION
do
    case "$OPTION" in
    a)
        account=${OPTARG}
        ;;
    t)
        tst=1
        ;;
	? | : | h)
	    usage
	    ;;
  esac
done

# set the number to be the first non option
shift  "$(($OPTIND -1))"
number=$1

if [[ -z $account ]]
then
    account="courses0100"
fi

if [[ -z $number ]]
then
    usage
    exit 1
fi

cat square.tmpl | sed "s/NUMBER/$number/" | sed "s/ACCOUNT/$account/" > sbatch_square.sh

if [[ ! -z $tst ]]
then
    sbatch sbatch_square.sh
else
    echo "Take a look at sbatch_square.sh ."
fi

