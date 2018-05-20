#include<stdio.h>
#include<iostream>
#include<cuda.h>
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
	std::cout<<"Lets do this!!!\n";
}
