#! /bin/bash
#SBATCH --export=NONE
#SBATCH --account=courses0100
#SBATCH -t 00:10:00
#SBATCH --nodes=2
#SBATCH --ntasks=12
#SBATCH -p work

module load python
module load py-mpi4py

set -ex
srun -n 12 python hello.py
