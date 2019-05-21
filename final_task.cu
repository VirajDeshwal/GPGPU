#include<stdio.h>
#include< assert.h>
using namespace std;


//cuda error check
inline cudaError_t checkCuda(cudaError_t, result)

{
    if(result != cudaSuccess)
    {
        printf(stdder, "CUDA Runtime Error: %s\n", cudaErrorString(result));
        assert(result == cudaSuccess);
    }
    return result;
}



void initWith(float num, float *a, int N)
{
    for(int i= 0; i <N; ++i)
    {
        a[i] = num;
    }
}




__global__ void addVectorInto(float *result, float *a, float *b, int N)
{
    //Defining the size of the data index to avoid overflow.
    int index = threadIdx.x + blockIdx.x * blockDim.x;

    //Defining the stride to devide the element operation equally of each threadIndex.
    int stride = blockDim.x * gridDim.x;

    for(int i=0; i<N; i+=stride)
    {
        result = a[i] + b[i];
    }
}

/* For cpu
We will convert the cpu operation to GPU program

void addVectorInto(float *result, float *a, float *b, int N)
{
    for(int i=0; i<N; ++i)
    {
        result[i] = a[i] + b[i];
    }
}


*/

//condition check
void checkElementsAre(float target, float *array, int N)
{
    for(int i=0; i<N; i++)
    {
        if(array[i] != target)
        {
            printf("Fail: array[%d] - %0.0f does not equal to %0.0f\n", i , array[i], target);
            exit(1);
        }
    }
    printf("Success!");
}


//main()

int main()
{
    const int N = 2<<20;  // bitwise shift operation
    size_t size = N*sizeof(float); // definging the size in HEAP.

    float *a;
    float *b;
    float *c;
/*
Changing the memory management function from CPU to GPU.
    //Defining the memory of each variable in Heap.
    a = (float *) malloc(size); // defining the partitions in Size(Heap)
    b = (float *) malloc(size);
    c = (float *) malloc(size);

    addVectorInto(c,a,b, N);
    checkElementsAre(7, c, N);

    free(a);
    free(b);
    free(c);
*/

checkCuda( cudaMallocManaged( &a, size)));
checkCuda( cudaMallocManaged( &b, size));
checkCuda( cudaMallocManaged( &c, size));

size_t threadPerBlock;
size_t numberOfBlocks;
threadPerBlock = 256;

numberOfBlocks = (N + threadPerBlock -1) / threadPerBlock;

addVectorInto<<< numberOfBlocks, threadPerBlock>>>(c, a, b, N);

checkCuda( cudaGetLastError() );
checkCuda( cudaDeviceSyncronize() );

checkElementsAre(7, c, N);

checkCuda( cudaFree(a) );
checkCuda( cudaFree(b) );
checkCuda( cudaFree(c) );

}



}