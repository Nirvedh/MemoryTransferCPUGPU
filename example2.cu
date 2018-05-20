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
	int* a = (int*) malloc (nBlocks*bDim*sizeof(int));// Allocate CPU Memory 
	for(int i=0;i<nBlocks*bDim;i++) // Initalize CPU array
		a[i]=i;
	int* da;
	cudaMalloc(&da,nBlocks*bDim*sizeof(int)); // Initalize GPU array
	cudaMemcpy(da,a,nBlocks*bDim*sizeof(int),cudaMemcpyHostToDevice); // CPU->GPU

	add<<<nBlocks,bDim>>>(da); // Call addition kernel
	cudaMemcpy(a,da,nBlocks*bDim*sizeof(int),cudaMemcpyDeviceToHost); // GPU->CPU
	for(int i=0;i<nBlocks*bDim;i++) // Print final results
		std::cout<<a[i]<<"\n";
	free(a);
	cudaFree(da);
	a=NULL;
	da=NULL;
	
}
