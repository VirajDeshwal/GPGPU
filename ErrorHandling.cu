#include<stdio.h>


//cudaError_t type to define error variable

cudaError_t err;
err = cudaMallocManaged(&a, N);

if(err != cudaSuccess)
{
    printf("Error: %s\n", cudaGetErrorString(err));
}

/*
Launching kernels, which are defined to return void, 
do not return a value of type cudaError_t. 
To check for errors occuring at the time of a kernel 
launch, for example if the launch configuration is erroneous, 
CUDA provides the cudaGetLastError function, 
which does return a value of type cudaError_t.
*/

/*
 * The macro can be wrapped around any function returning
 * a value of type `cudaError_t`.
 */

 checkCuda( cudaDeviceSynchronize())
}
