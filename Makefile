COMPILER = g++
FLAGS_CPP = -o
FLAGS_CU = -g -G -o
FLAGS_EXTRA = -Wextra
EXE = prog
SRC_CU = *.cu
SRC_CPP = *.cpp
LINK = -lopencv_core -lopencv_highgui -lopencv_imgproc 
LINK_NONFREE = -lopencv_nonfree -lopencv_features2d -lopencv_flann -lopencv_calib3d
NVCC = /usr/local/cuda/bin/nvcc
ARCH = -arch=sm_11
LINK_GPU = -lIlmImf -lImath -lHalf

#compiling
main:
	$(COMPILER) $(SRC_CPP) $(LINK) $(LINK_NONFREE) $(INCLUDE) $(FLAGS_CPP) $(EXE)
	
run:
	@echo "running the program"
	./$(EXE)
	
extra:
	$(COMPILER) $(SRC_CPP) $(LINK) $(INCLUDE) $(FLAGS_CPP) $(FLAGS_EXTRA) $(EXE)

GPU:
	$(NVCC) $(SRC_CU) $(LINK) $(LINK_GPU) $(INCLUDE) $(FLAGS_CU) $(EXE) $(ARCH) 
