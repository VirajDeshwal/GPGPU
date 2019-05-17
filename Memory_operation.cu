#include<iostream>
using namespace std;

class Memory()
{
public:
    int N = 2<<20;
    int *a;
    size_t size = N*sizeof(int);

//for CPU
/* For CPU we will use 
1. malloc -> to create a memory into Heap.
2. free -> reference to pointer to free the space 
*/
void cpu()
{
//Using the left shift operator operation





//using a reference pointer to create a memory into Heap.
a = (int *) malloc(size);

free(a);
}

void gpu()
{
    int *a;
    cudaMallocManaged(&a, size);
    cudaFree(a);
}
};

int main()
{
    cpu();
    gpu();
    
    return 0;
}


/* 
iteration N

__global__ gpu()
{
    printf("", threadIdx.x);
}

int main()
{
    iteration N;
    gpu<<< 1, N>>>();
}