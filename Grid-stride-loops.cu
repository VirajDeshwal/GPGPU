#include <stdio.h>

/*
CUDA provides a special variable giving the number of blocks 
in a grid, gridDim.x. Calculating the total number of 
threads in a grid then is simply the number of blocks in a grid multiplied by 
the number of threads in each block, gridDim.x * blockDim.x. 
*/

__global__ void kernel(int *a, int N)
{
    int indexWithinGrid = threadIdx.x + blockIdx.x * blockDim.x;

    int gridStride = gridDim.x * blockDim.x;

    for(int i = indexWithinGrid; i< N; i += gridStride)
    {
        //do work on a[i];
    }
}