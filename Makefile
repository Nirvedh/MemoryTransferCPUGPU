all: example1 example2 example3 example4
example1: example1.cu
	/local/linux/cuda-7.5/bin/nvcc example1.cu -o example1
example2: example2.cu
	/local/linux/cuda-7.5/bin/nvcc example2.cu -o example2
example3: example3.cu
	/local/linux/cuda-7.5/bin/nvcc example3.cu -o example3
example4: example4.cu
	/local/linux/cuda-7.5/bin/nvcc example4.cu -o example4
	
