#! /bin/bash
#SBATCH --export=NONE
#SBATCH --account=courses0100
#SBATCH -t 00:10:00
#SBATCH --nodes=2
#SBATCH --ntasks=12
#SBATCH -p work

module load python/3.10.10
module load py-mpi4py/3.1.4-py3.10.10

set -ex
srun -n 12 python hello.py
