#! /bin/bash
#SBATCH --export=NONE
#SBATCH --account=courses0100
#SBATCH -t 00:10:00
#SBATCH --nodes=2
#SBATCH --ntasks=12
#SBATCH -p work

module load python/3.11.6
module load py-mpi4py/4.0.1-py3.11.6

set -ex
srun -n 12 python hello.py
