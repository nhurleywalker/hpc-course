#/usr/bin/env python

import argparse
import numpy as np
import h5py
import sys
import multiprocessing as mp

# Useful h5py examples here:
# https://www.christopherlovell.co.uk/blog/2016/04/27/h5py-intro.html

def createCube(sides = 3, length = 100):
    ''' Create a cube of random data '''
    dimensions = np.tile(length, sides)
    cube = np.random.random_sample(dimensions)
    return cube

def writeCube(cube = None, outfile = None):
    ''' Create a simple hdf5 file '''
    hf = h5py.File(outfile, 'w')
    hf.create_dataset('dataset', data=cube)
    hf.close()

def averageCube(infile = None, row=0):
    hf = h5py.File(infile, 'r')
    data = np.array(hf.get('dataset')[:,:,row])
    a = np.average(data)
    hf.close()
    del data
    return a

def calc_average_parallel(infile = None, nprocs = 1):
    ''' Average 2D slices using parallel processing
    parameters
    ----------
    filename : str
        The filename of the table to be read
    nprocs : int
        Number of processes to use simultaneously
    return
    ------
        An array of averages, not necessarily in the same order as the input!
    '''
    results = []

    def collect_result(result):
        results.append(result)

    hf = h5py.File(infile, 'r')
    data = hf.get('dataset')
    n = data.shape[0]
    hf.close()
    pool = mp.Pool(nprocs)
    for i in range(n):
        pool.apply_async(averageCube,
                         args=[infile],
                         kwds={'row':i},
                         callback=collect_result)
    pool.close()
    pool.join()
    final = np.vstack(results)
    return final

if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    group1 = parser.add_argument_group("Global options")
    group1.add_argument("--file", dest='filename', type=str, default="data.h5",
                        help='The name of the HDF5 file; default = data.h5')
    group1.add_argument('--cores', dest='cores', default=None, type=int,
                        help="NUmber of cores to use (default = autodetect)")
    group2 = parser.add_argument_group("Cube creation options")
    group2.add_argument("--create", dest='create', action="store_true", default=False,
                        help="Create the file (overrrides all other actions)")
    group2.add_argument("--sides", dest='sides', type=int, default=3,
                        help="Number of sides of cube")
    group2.add_argument("--length", dest='length', type=int, default=100,
                        help="Length of sides of cube")
    options = parser.parse_args()

    if options.cores is None:
        cores = mp.cpu_count()
    else:
        cores = options.cores
    if options.create is True:
        cube = createCube(options.sides, options.length)
        writeCube(cube, options.filename)
    else:
        a = calc_average_parallel(infile = options.filename, nprocs = cores)
        np.savetxt("results.txt", a)
