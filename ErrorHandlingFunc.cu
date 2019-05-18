#include<stdio.h>
#include<assert.h>

inline cudaError_t checkCuda(cudaError_t result)
{
    if(result != cudaSuccess)
    {
        fprintf(stdder, "CUDA Runtime Error: %s\n", cudaErrorString(result));
        assert(result == cudaSuccess);
    }
    return result; 
}

int main()
{
/* The macro can be wrapped around any function returning
   a value of type 'cudaError_t'.
*/

    checkCuda(cudaDeviceSynchronize())
}
