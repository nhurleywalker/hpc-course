#! /bin/bash
#SBATCH --export=NONE
#SBATCH --account=courses0100
#SBATCH -t 00:10:00
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH -p work
#SBATCH --array=1000-1100

n=${SLURM_ARRAY_TASK_ID}

./square.sh $n
