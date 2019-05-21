#include<stdio.h>
#include<assert.h>

//Host function to initialize vector elements.

void initwith(float num, float *a, int N)
{
    for(int i=0; i<N; ++i)
    {
        a[i] = num;
    }
}

//kernel
__global__ void addVectorInto(float *result, float *a, float *b, int N)
{
    int index = threaIdx.x + blockIdx.x * blockDim.x;
    int stride = blockDim.x * gridDim.x;
    
    for(int i=0; i< N; i += stride)
    {
        result[i] = a[i]+b[i];
    }
}

//check elements
void checkElementsAre(float target, float *vector, int N)
{
    for(int i=0; i<N; i++)
    {
        if(vector[i] != target)
        {
            printf("Fail: vector[%d] - %0.0f does not equal to %0.0f\n", i, vector[i], target);
            exit(1);
        }
    }
    printf("Success.");
}

int main()

const int N = 2<<20;
size_t size = N *sizeof(float);

float *a;
float *b;
float *c;

cudaMallocManaged( (&a, size) );
cudaMallocManaged( (&b, size) );
cudaMallocManaged( (&c, size) );

initWith(3, a, N);
initWith(4, b, N);
initWith(0, c, N);

size_t threadPerBlock = 1;
size_t numberOfBlocks = 1;

cudaError_t addVectorsErr;
cudaError_t asyncErr;

addVectorsInto<<<numberOfBlocks, threadsPerBlock>>>(c, a, b, N);

addVectorsErr = cudaGetLastError();
if(addVectorsErr != cudaSuccess) printf("Error: %s\n", cudaGetErrorString(addVectorsErr));

asyncErr = cudaDeviceSynchronize();
if(asyncErr != cudaSuccess) printf("Error: %s\n", cudaGetErrorString(asyncErr));

checkElementsAre(7, c, N);

cudaFree(a);
cudaFree(b);
cudaFree(c);
}

