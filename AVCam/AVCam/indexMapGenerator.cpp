//
//  indexMapGenerator.cpp
//  AVCam
//
//  Created by Siddhartha Chandra on 5/8/14.
//  Copyright (c) 2014 Apple Inc. All rights reserved.
//

#include "indexMapGenerator.hpp"


using namespace cv;
using namespace std;


Mat indexMapGenerator::toGray(Mat img){
    
    
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
			grayPtr[idxGray] = ((float)imgPtr[idxImg]+(float)imgPtr[idxImg+1]+(float)imgPtr[idxImg+2])/(3.0*100);	//TODO take out scale factor 100
		}
	}
	
	return grayImg;
}

Mat indexMapGenerator::alignImages(vector<Mat> imageStack)
{
    return imageStack[0];
}

Mat indexMapGenerator::lap_dir(Mat img, int direction)
{
	//int cols = img.cols;
	//int rows = img.rows;
	
	Mat img_filtered;
	
	if (direction%2)
	{
		float vertical_fk[1][3] = {1,-2,1};
		Mat filter_kernel = Mat(1, 3, CV_32FC1, vertical_fk);
		filter2D(img, img_filtered, -1, filter_kernel);
	}
	else
	{
		float horizontal_fk[3][1] = {{1}, {-2}, {1}};
		Mat filter_kernel = Mat(3, 1, CV_32FC1, horizontal_fk);
		filter2D(img, img_filtered, -1, filter_kernel);
	}
    
    
	return img_filtered;
    
}

Mat indexMapGenerator::generateFocalIndexMap(vector<Mat> imageStack)
{
    
//    Mat imageStackLocal;
//    cvCopy(&imageStack, &imageStackLocal);
    const int N=25;
    Mat grayStack[N];
	Mat focal_Measure[N];
	
    
	Mat lap_x;
	Mat lap_y;
    
    // kernel for boosting intensity of modified laplacian
	float kernel[3][3] = {{1,1,1}, {1,1,1}, {1,1,1}};
	Mat boostingFilter = Mat(3, 3, CV_32FC1, kernel);

    int i,x,y;
    
    for(i = 0; i < imageStack.size(); i++)
    {
        //Create a new Gray scale image
        
        Mat grayImg;// = toGray(imageStack[i]);
        Mat grayImgFloat;
		cvtColor(imageStack[i],grayImg,CV_BGR2GRAY,1);
		grayImg.convertTo(grayImgFloat,CV_32FC1,1/255.0);
        
        grayStack[i] = grayImgFloat;
        
        //grayStack[i] = imageStack[i];

        lap_x=lap_dir(grayStack[i],0);
		lap_y=lap_dir(grayStack[i],1);
        
        lap_x=abs(lap_x);
		lap_y=abs(lap_y);
        
        Mat modLaplacian;
		addWeighted(lap_x,1,lap_y,1,0.0,modLaplacian);
        
        //locally boosting all pixel intensities based on a 3X3 neighborhood
		Mat boosted;
		filter2D(modLaplacian, boosted, -1, boostingFilter);
        
        //averaging values of the focal measure: average filter preferred ouver gaussian filter as gaussian does not resolve the issue of noisy patches
		Size ksize(19,19);
		Mat modLapSmooth;
		boxFilter(boosted,modLapSmooth,-1,ksize);
        
        focal_Measure[i]=modLapSmooth;
        
    }
    
    int rows;
	int cols;
    
	rows=focal_Measure[0].rows;
	cols=focal_Measure[0].cols;
    
	cout<<focal_Measure[0].rows<<endl;
	cout<<focal_Measure[0].cols<<endl;
    
	Mat focusMap= Mat::zeros( rows, cols, CV_8UC1);
	int  maxK;
	double maxVal;
	double tempVal;

    for(y = 0; y < rows; y++)
	{
	  	for(x = 0; x < cols; x++)
	  	{
            
	  		//Iterate over all the images on the stack and get the one in focus.
	  		maxK=0;
	  		maxVal=focal_Measure[0].at<float>(y,x);
	 		for(int k =1; k< imageStack.size(); k++)
	 		{
	 			tempVal=focal_Measure[k].at<float>(y,x);
	 			// cout<<tempVal<<endl;
	 			if(tempVal>maxVal)
	 			{
	 				maxK=k;
	 				maxVal=tempVal;
	 			}
	  		}
	  		focusMap.at<uchar>(y,x)=maxK;		//TODO take out this scale factor. For visialization and debug
	  	}
        
 	}

    return focusMap;
}

