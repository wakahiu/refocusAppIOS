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
			grayPtr[idxGray] = ((float)imgPtr[idxImg]+(float)imgPtr[idxImg+1]+(float)imgPtr[idxImg+2])/(3.0*100);	//TODO take out scale factor 100
		}
	}
	
	return grayImg;
}


Mat lap_dir(Mat img, int direction)
{
	int cols = img.cols;
	int rows = img.rows;
	
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
	
int main()
{
	
	int N = 25;
	Mat imageStack[25];
	Mat grayStack[25];
	Mat focal_Measure[25];
	

	Mat lap_x;
	Mat lap_y;


	
	// kernel for boosting intensity of modified laplacian
	float kernel[3][3] = {{1,1,1}, {1,1,1}, {1,1,1}};
	Mat boostingFilter = Mat(3, 3, CV_32FC1, kernel);
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
		
		int rows;
		int cols;

		rows=focal_Measure[0].rows;
		cols=focal_Measure[0].cols;
		
		//Create a new Gray scale image

		Mat grayImg = toGray(imageStack[i] );
		grayStack[i] = grayImg;
		

		//sid
		Mat gray_image;
 		//cvtColor( imageStack[i], gray_image, CV_BGR2GRAY );
 		//grayStack[i]=gray_image;

		lap_x=lap_dir(grayStack[i],0);
		lap_y=lap_dir(grayStack[i],1);
		


		lap_x=abs(lap_x);
		lap_y=abs(lap_y);
		
		

		Mat modLaplacian;
		addWeighted(lap_x,1,lap_y,1,0.0,modLaplacian);
		
		Size ksize(9,9);
		float sigma = 10.0;
		Mat modLapSmooth;
		GaussianBlur(modLaplacian,modLapSmooth,ksize,sigma);
		
		//locally boosting all pixel intensities based on a 3X3 neighborhood
		//Mat boosted( rows, cols, CV_32FC1);
		//filter2D(modLaplacian, boosted, -1, boostingFilter);
		
		//averaging values of the focal measure
		//Mat focal_measure_avg;
		//boxFilter(boosted, focal_measure_avg,-1, [19 19]);		//TODO

		focal_Measure[i]=modLapSmooth;
		
		continue;
		
				
		namedWindow(buffer,WINDOW_AUTOSIZE);
		imshow(buffer,modLapSmooth);
		waitKey(0);

		
		
	
	
	}

	for(int i = 0; false && i < N ; i++){
		int u = 100;
		int v = 200;
		cout<< focal_Measure[i].at<float>(u,v)<<endl;
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

	cout<<"start"<<endl;
	

	for(int y = 0; y < rows; y++)
	{
	  	for(int x = 0; x < cols; x++)
	  	{
			
	  		//Iterate over all the images on the stack and get the one in focus.
	  		maxK=0;
	  		maxVal=focal_Measure[0].at<float>(y,x);
	 		for(int k =1; k< N; k++)
	 		{
	 			tempVal=focal_Measure[k].at<float>(y,x);
	 			// cout<<tempVal<<endl;
	 			if(tempVal>maxVal)
	 			{
	 				maxK=k;
	 				maxVal=tempVal;
	 			}
	  		}
	  		focusMap.at<uchar>(y,x)=maxK*10;		//TODO take out this scale factor. For visialization and debug	
	  	}
			
 	}

	//Focus does not change rapidly among objects. 
	//Smooth it!
	Size ksize(9,9);
	float sigma = 12.0;
	Mat focusMapSmooth;
	GaussianBlur(focusMap,focusMapSmooth,ksize,sigma);
	
	namedWindow("focusMap",WINDOW_AUTOSIZE);
	imshow("focusMap",focusMapSmooth);
	waitKey(0);
	return 0;
}
