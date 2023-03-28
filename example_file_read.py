import numpy as np
import timeit

# Define the dimensions of the array
X_DIM = 10
Y_DIM = 10
T_DIM = 10
F_DIM = 10

# Generate some random data
data = np.random.rand(T_DIM, Y_DIM, X_DIM, F_DIM)

# Write the data to a file in slices along the t-axis
with open("data.bin", "wb") as file_obj:
    for t in range(T_DIM):
        slice = data[t, :, :, :].astype(np.float32)
        slice.tofile(file_obj)

# Read the data from the file along the t-axis
def read_t_axis():
    with open("data.bin", "rb") as file_obj:
        for t in range(T_DIM):
            slice = np.fromfile(file_obj, dtype=np.float32, count=X_DIM * Y_DIM * F_DIM)
            slice = np.reshape(slice, (Y_DIM, X_DIM, F_DIM))

read_t_axis_time = timeit.timeit(read_t_axis, number=1)
print("Reading the file along the t-axis took", read_t_axis_time, "seconds")

# Read the data from the file along the x-axis
def read_x_axis():
    with open("data.bin", "rb") as file_obj:
        for x in range(X_DIM):
            for y in range(Y_DIM):
                for f in range(F_DIM):
                    for t in range(T_DIM):
                        value = np.fromfile(file_obj, dtype=np.float32, count=1)

read_x_axis_time = timeit.timeit(read_x_axis, number=1)
print("Reading the file along the x-axis took", read_x_axis_time, "seconds")
