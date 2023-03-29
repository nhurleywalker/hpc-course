#! /bin/bash

#SBATCH --export=NONE
#SBATCH --account=courses0100
#SBATCH -t 00:10:00
#SBATCH --nodes=2
#SBATCH --ntasks=37
#SBATCH -p workq

module swap gcc/5.5.0 gcc/4.8.5
module load python/3.6.3 mpi4py

set -ex
cd /group/courses0100/phancock/mpi4py
srun -n 37 python hello.py
