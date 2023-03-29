#!/usr/bin/env python
'''
Parallel Hello World
'''

from mpi4py import MPI

size = MPI.COMM_WORLD.Get_size()
rank = MPI.COMM_WORLD.Get_rank()
name = MPI.Get_processor_name()

print("Hello, World! I am process {0} of {1} on {2}.".format(rank, size, name))