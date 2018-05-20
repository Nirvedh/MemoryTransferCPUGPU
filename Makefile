all: example1 example2 example3 example4a example4b example4c example4d
example1: example1.cu
	/local/linux/cuda-7.5/bin/nvcc example1.cu -o example1
example2: example2.cu
	/local/linux/cuda-7.5/bin/nvcc example2.cu -o example2
example3: example3.cu
	/local/linux/cuda-7.5/bin/nvcc example3.cu -o example3
example4a: example4a.cu
	/local/linux/cuda-7.5/bin/nvcc example4a.cu -o example4a
example4b: example4b.cu
	/local/linux/cuda-7.5/bin/nvcc example4b.cu -o example4b
example4c: example4c.cu
	/local/linux/cuda-7.5/bin/nvcc example4c.cu -o example4c
example4d: example4d.cu
	/local/linux/cuda-7.5/bin/nvcc example4d.cu -o example4d

