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


Mat lap_dir(Mat img, int direction)
{
	
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

		//float horizontal_fk[5][5] = {{0,0,-1,0,0}, {0,0,-2,0,0}, {0,0,6,0,0}, {0,0,-2,0,0}, {0,0,-1,0,0}};
		//Mat filter_kernel = Mat(5, 5, CV_32FC1, horizontal_fk);
		//filter2D(img, img_filtered, -1, filter_kernel);
	}


	return img_filtered;

}


Mat lap(Mat img,int direction){


	//We only need one channel
	Mat gradImg(img.rows, img.cols,CV_32FC1);
	
	float * gradPtr = (float *)gradImg.data;
	
	float * imgPtr = (float *) img.data;
	int grayStep = gradImg.step/sizeof(float);
	
	
	if(direction % 2){
		//Loop over the image pixels. Convert to float to avoid precision issues.
		for(int  y = 1; y < img.rows-1; y++){
			for(int  x = 1; x < img.cols-1; x++){
			
				int idx = y*grayStep + x;
				gradPtr[idx] = (gradPtr[idx+1] + gradPtr[idx-1] - 2*gradPtr[idx])*25;
			}
		}
	}
	else{
		//Loop over the image pixels. Convert to float to avoid precision issues.
		for(int  y = 1; y < img.rows-1; y++){
			for(int  x = 1; x < img.cols-1; x++){
			
				int idx = y*grayStep + x;
				gradPtr[idx] = (gradPtr[idx+grayStep] + gradPtr[idx-grayStep] - 2*gradPtr[idx])*25;
			}
		}
	}
	
	return gradImg;
}
	
int main()
{
	
	int N = 25;
	Mat imageStack[25];
	Mat grayStack[25];
	Mat focal_Measure[25];
	
	Mat boosted;

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
		
		//Create a new Gray scale image
		//Mat grayImg = toGray(imageStack[i] );
		//grayStack[i] = grayImg;
		

		//sid
		Mat gray_image;
 		cvtColor( imageStack[i], gray_image, CV_BGR2GRAY );
 		grayStack[i]=gray_image;

		lap_x=lap_dir(grayStack[i],0);
		lap_y=lap_dir(grayStack[i],1);

		lap_x=abs(lap_x);
		lap_y=abs(lap_y);

		Mat gradAbs;
		addWeighted(lap_x,1,lap_y,1,0.0,gradAbs);
		
		//locally boosting all pixel intensities based on a 3X3 neighborhood
		
		filter2D(gradAbs, boosted, -1, boostingFilter);

		//averaging values of the focal measure
		//Mat focal_measure_avg;
		//boxFilter(boosted, focal_measure_avg,-1, [19 19]);


		focal_Measure[i]=boosted;
		
		namedWindow(buffer,WINDOW_AUTOSIZE);
		imshow(buffer,boosted);
		waitKey(0);
		
	
	
	}

	cout<<boosted.rows<<endl;
	cout<<boosted.cols<<endl;

	int rows;
	int cols;

	rows=boosted.rows;
	cols=boosted.cols;

	Mat focusMap= Mat::zeros( rows, cols, CV_8SC1);
	int  maxK;
	double maxVal;
	double tempVal;

	cout<<"start"<<endl;
	waitKey(0);

	cout<< focal_Measure[0].at<uint>(10,10)<<endl;
	cout<< focal_Measure[1].at<uint>(10,10)<<endl;
	cout<< focal_Measure[2].at<uint>(10,10)<<endl;
	cout<< focal_Measure[3].at<uint>(10,10)<<endl;
	cout<< focal_Measure[4].at<uint>(10,10)<<endl;
	cout<< focal_Measure[5].at<uint>(10,10)<<endl;
	cout<< focal_Measure[6].at<uint>(10,10)<<endl;
	cout<< focal_Measure[7].at<uint>(10,10)<<endl;
	cout<< focal_Measure[8].at<uint>(10,10)<<endl;

	

	// for(int y = 0; y < rows; y++)
	// {
	//  	for(int x = 0; x < cols; x++)
	//  	{
			
	//  		//Iterate over all the images on the stack and get the one in focus.
	//  		maxK=0;
	//  		maxVal=focal_Measure[0].at<CV_32FC1>(y,x);
	//  		// float grad = 0.0;
	//  		//int idx = y*step+x;
	// 		waitKey(0);
	// 		//tempVal=focal_Measure[2].at<uchar>(y,x);
	//  		cout<<focal_Measure[0].at<CV_32FC1>(y,x)<<endl;
	//  		cout<<focal_Measure[1].at<CV_32FC1>(y,x)<<endl;
	//  		cout<<focal_Measure[2].at<CV_32FC1>(y,x)<<endl;
	//  		cout<<focal_Measure[3].at<CV_32FC1>(y,x)<<endl;
	//  		cout<<focal_Measure[4].at<CV_32FC1>(y,x)<<endl;
	//  		cout<<focal_Measure[5].at<CV_32FC1>(y,x)<<endl;
	//  		cout<<focal_Measure[6].at<CV_32FC1>(y,x)<<endl;
	//  		cout<<focal_Measure[7].at<CV_32FC1>(y,x)<<endl;
	//  		cout<<focal_Measure[8].at<CV_32FC1>(y,x)<<endl;
	 		

	// 		for(int k =1; k< N; k++)
	// 		{
	// 			// tempVal=focal_Measure[k].at<uchar>(y,x);
	// 			// cout<<tempVal<<endl;

				
	// 			if(tempVal>maxVal)
	// 			{
	// 				maxK=k;
	// 				maxVal=tempVal;
	// 			}

	// //cout<<focal_Measure.at<uchar>;
	// // 			float * currImgPtr = (float *) gradStack[k].data;
	// // 			if(currImgPtr[idx] > grad){
	// // 				grad  = currImgPtr[idx]
	// // 				maxK = k;
	// // 				//cout << k << " k" << endl;
	//  		}

	//  		focusMap.at<uchar>(y,x)=maxK;	
	//  	}
			
	// }


	// //cout<<focusMap;
	// //cout<<maxVal<<endl;

	// // Mat g;
	// // g = Mat::zeros(Size(boosted.rows, boosted.cols), CV_8UC1);
	// // rando.push_back(g);
	// // rando.push_back(g);
	// // rando.push_back(boosted);

	// // Mat focal_measure_combined;
	// // merge(rando,focal_measure_combined);

	

	// // int cols = gradStack[0].cols;
	// // int rows = gradStack[0].rows;
	// // int step = gradStack[0].step/sizeof(float);
	// // Mat focusMap(gradStack[0].rows, gradStack[0].cols,CV_8UC1);
	
	// // unsigned char * focusMapPtr = focusMap.data;
	
	// // //cout << "step " << step << " cols " << cols << " rows " << rows <<  endl;
	// // //Generate an index map. For each pixel, the index map tells us the index of
	// // //The image that is in focucs.
	

	// // }
	
	// namedWindow("focusMap",WINDOW_AUTOSIZE);
	// imshow("focusMap",boosted);
	// waitKey(0);
	return 0;
}
