#! /bin/bash
#SBATCH --export=NONE
#SBATCH --account=courses0100
#SBATCH -t 00:10:00
#SBATCH --nodes=2
#SBATCH --ntasks=37
#SBATCH -p workq

module load python
module load mpi4py

set -ex
srun -n 37 python hello.py
