GENCODE_FLAGS = -gencode arch=compute_30,code=sm_30 -gencode arch=compute_35,code=sm_35 -gencode arch=compute_37,code=sm_37 -gencode arch=compute_50,code=sm_50 -gencode arch=compute_52,code=sm_52 -gencode arch=compute_60,code=sm_60 -gencode arch=compute_61,code=sm_61, -gencode arch=compute_70,code=sm_70


convolution:convolution.o
	nvcc  $^ -o $@ -lcudnn ${GENCODE_FLAGS}

convolution.o:convolution.cu implicit_gemm_kernel.h
	nvcc -c $< -o $@ -Xptxas -v -lineinfo --std=c++11 ${GENCODE_FLAGS}

clean:
	rm -f convolution convolution.o
