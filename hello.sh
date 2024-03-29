#! /bin/bash
#SBATCH --export=NONE
#SBATCH --account=courses0100
#SBATCH -t 00:10:00
#SBATCH --nodes=2
#SBATCH --ntasks=12
#SBATCH -p work

module load python/3.9.15
module load py-mpi4py/3.1.2-py3.9.15

set -ex
srun -n 12 python hello.py
