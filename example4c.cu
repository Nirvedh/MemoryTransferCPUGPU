#include<stdio.h>
#include<iostream>
#include<cuda.h>
#include"example.h"
__global__ void add(exampleStruct* example){// Addition Kernel
	exampleStruct my_example = example[blockIdx.x];
	my_example.index[threadIdx.x]+= my_example.base*blockDim.x+1000;
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
	exampleStruct* example,*iexample,*dexample;
	example = (exampleStruct*) malloc (nBlocks*sizeof(exampleStruct));// Allocate CPU Memory 
	iexample = (exampleStruct*) malloc (nBlocks*sizeof(exampleStruct));// Allocate CPU Memory
	cudaMalloc(&dexample,nBlocks*sizeof(exampleStruct));
	
	for(int i=0;i<nBlocks;i++){// Initalize CPU array
		example[i].base=i;
		example[i].index= (int*)malloc (bDim*sizeof(int));
		for(int j=0;j<bDim;j++){
			example[i].index[j]=j;
		}
	}
	// load into intermediate
	for(int i=0;i<nBlocks;i++){
		iexample[i].base=example[i].base;
		cudaMalloc(&iexample[i].index,nBlocks*sizeof(exampleStruct));
		cudaMemcpy(iexample[i].index,example[i].index,sizeof(exampleStruct),cudaMemcpyHostToDevice);
	}
	
	cudaMalloc(&dexample,nBlocks*sizeof(exampleStruct)); // Initalize GPU array
	cudaMemcpy(dexample,iexample,nBlocks*sizeof(exampleStruct),cudaMemcpyHostToDevice); // CPU->GPU

	add<<<nBlocks,bDim>>>(dexample); // Call addition kernel
	// Error check
        cudaError_t cudaerr1 = cudaDeviceSynchronize();
                if (cudaerr1 != cudaSuccess)
                        printf("kernel launch failed with error \"%s\".\n",
                                        cudaGetErrorString(cudaerr1));
	
	cudaMemcpy(iexample,dexample,nBlocks*sizeof(exampleStruct),cudaMemcpyDeviceToHost); // GPU->CPU
	// Copy back from intermediate
	for(int i=0;i<nBlocks;i++){
          	example[i].base=iexample[i].base;
                cudaMemcpy(example[i].index,iexample[i].index,sizeof(exampleStruct),cudaMemcpyDeviceToHost);
        }




	for(int i=0;i<nBlocks;i++) // Print final results
		for(int j=0;j<bDim;j++)
			std::cout<<example[i].index[j]<<"\n";
	free(example);
	cudaFree(dexample);
	example=NULL;
	dexample=NULL;
	
}
