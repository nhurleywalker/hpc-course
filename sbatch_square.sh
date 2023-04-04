#! /bin/bash
#SBATCH --export=NONE
#SBATCH --account=courses0100
#SBATCH -t 00:10:00
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH -p work

n=8

./square.sh $n
