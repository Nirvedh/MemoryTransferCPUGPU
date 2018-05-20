#include<stdio.h>
#include<iostream>
#include<cuda.h>
__global__ void add(int* a){ // Addition Kernel
	int tid = blockIdx.x*blockDim.x+threadIdx.x;
	a[tid]+=tid;
}
int main(int argc, char* argv[]){
	if(argc!=3){
		std::cout<<"Usage: "<<argv[0]<<" Numblocks BlockDim\n";
		return 0;
	}
	int nBlocks= atoi(argv[1]);
	int bDim = atoi(argv[2]);
	if(bDim>1024){
	std::cout<<"BlockDim should be less than or equal to 1024\n";
	return 0;
	}
	int* da;
 	cudaMallocManaged (&da, nBlocks*bDim*sizeof(int));// Allocate CPU/GPU Memory 
	for(int i=0;i<nBlocks*bDim;i++) // Initalize CPU array
		da[i]=i;
	add<<<nBlocks,bDim>>>(da); // Call addition kernel
	cudaDeviceSynchronize();
	for(int i=0;i<nBlocks*bDim;i++) // Print final results
		std::cout<<da[i]<<"\n";
	cudaFree(da);
	da=NULL;
	
}
