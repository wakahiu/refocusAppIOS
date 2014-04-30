#include "commonHeaders.h"

Mat toGray(Mat img){


	//We only need one channel
	Mat grayImg(img.rows, img.cols,CV_32FC1);
	
	float * grayPtr = (float *)grayImg.data;
	unsigned char * imgPtr = (unsigned char *) img.data;
	int grayStep = grayImg.step/sizeof(float);
	int imgStep = img.step/sizeof(unsigned char);
	
	//Loop over the image pixels. Convert to float to avoid precision issues.
	for(int  y = 0; y < img.rows; y++){
		for(int  x = 0; x < img.cols; x++){
			
			int idxGray = y*grayStep + x;
			int idxImg = y*imgStep + x*3;
			grayPtr[idxGray] = ((float)imgPtr[idxImg]+(float)imgPtr[idxImg+1]+(float)imgPtr[idxImg+2])/(3.0);
		}
	}
	
	return grayImg;
}
	
int main()
{
	
	int N = 25;
	Mat imageStack[N];
	Mat grayStack[N];
	Mat gradStack[N];
	
	//Load the image stack and convert it to grayscale.
	//TODO !
	//Loaded images in unint8. Consider changing them to float during grayscale
	//Conversion for arithmetic precision. 
	for(int i = 0; i < N; i++){
		char buffer[50];
		sprintf(buffer,"stack/frame%d.jpg",i+1);
		imageStack[i] = imread(buffer);
		
		if(!imageStack[i].data){
			cerr << "Could not open or find the image" << endl;
			exit(0);
		}
		
		//Create a new Gray scale image
		Mat grayImg = toGray(imageStack[i] );
		grayStack[i] = grayImg;
		
		
		//Get the gradients
		Mat grad_x;
		Mat grad_y;
		
		//Gradient X
		int ddepth = grayStack[i].depth();
		int deriv_x = 1; 	//order of the x derivative.
		int deriv_y = 0; 	//order of the y derivative.
		int ksz =5;			//Size of the kernel.
		
		
		Sobel(grayStack[i],grad_x,ddepth,deriv_x,deriv_y,ksz); 
		abs(grad_x);
		
		//Gradient X
		deriv_x = 0; 		//order of the x derivative.
		deriv_y = 1; 		//order of the y derivative.
		Sobel(grayStack[i],grad_y,ddepth,deriv_x,deriv_y,ksz); 
		abs(grad_y);
		
		//Total gradient (approximate)
		Mat gradAbs;
		addWeighted(grad_x,0.5,grad_y,0.5,0.0,gradAbs);
		gradStack[i] = gradAbs;
		
		
		namedWindow(buffer,WINDOW_AUTOSIZE);
		imshow(buffer,gradAbs);
		waitKey(0);
		
	
	
	}

	int cols = gradStack[0].cols;
	int rows = gradStack[0].rows;
	int step = gradStack[0].step/sizeof(float);
	Mat focusMap(gradStack[0].rows, gradStack[0].cols,CV_8UC1);
	
	unsigned char * focusMapPtr = focusMap.data;
	
	//cout << "step " << step << " cols " << cols << " rows " << rows <<  endl;
	//Generate an index map. For each pixel, the index map tells us the index of
	//The image that is in focucs.
	
	for(int y = 0; y < rows; y++){
		for(int x = 0; x < cols; x++){
			
			//Iterate over all the images on the stack and get the one in focus.
			int  maxK=0;
			float grad = 0.0;
			int idx = y*step+x;
			
			for(int k =0; k< N; k++){
				float * currImgPtr = (float *) gradStack[k].data;
				
				if(currImgPtr[idx] > grad){
					grad  = currImgPtr[idx];
					maxK = k;
				}
			}
			
			focusMapPtr[idx] = maxK*10;
			
		}
	}
	
	namedWindow("focusMap",WINDOW_AUTOSIZE);
	imshow("focusMap",focusMap);
	waitKey(0);
	return 0;
}
