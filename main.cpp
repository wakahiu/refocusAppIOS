#include "commonHeaders.h"


int x_coord=-1;
int y_coord=-1;

//Plots a green dot around point (x,y)
void plot(Mat img,int x,int y,int b, int g, int r){
	
	int k=10;
	unsigned char * imgPtr = (unsigned char *)img.data;
	
	for(int j = y-k; j < y+k; j++){
		for(int i = x-k; i < x+k; i++ ){
		
			//Bounds check
			if( j < 0 || j >= img.rows || i < 0 || i >= img.cols){
				continue;
			}
	
			imgPtr[img.step*j+i*3+0] = b;
			imgPtr[img.step*j+i*3+1] = g;
			imgPtr[img.step*j+i*3+2] = r;
		}
	}
	
}

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

void CallBackFunc(int event, int x, int y, int flags, void* userdata)
{
     if  ( event == EVENT_LBUTTONDOWN )
     {
          cout << "Left button of the mouse is clicked - position (" << x << ", " << y << ")" << endl;
          x_coord=x;
     	  y_coord=y;
     }

      if ( flags == (EVENT_FLAG_CTRLKEY + EVENT_FLAG_LBUTTON) )
     {
          cout << "Left mouse button is clicked while pressing CTRL key - position (" << x << ", " << y << ")" << endl;
          x_coord=0;
     	  y_coord=0;
     }
     

}

void alignToPrevImage(Mat imgPrevUnAlligned,Mat imgNextUnAlligned, Mat imgPrev,Mat imgNext){
		int rows=imgPrevUnAlligned.rows;
		int cols=imgPrevUnAlligned.cols;
		int chans=imgPrevUnAlligned.channels();
		
		cout << "cols " << cols << " rows " << rows <<  " chans " << chans << endl;
		
		unsigned char * imgPrevPtr = (unsigned char *)imgPrevUnAlligned.data;
		unsigned char * imgNextPtr = (unsigned char *)imgNextUnAlligned.data;
		
		Mat imgP(rows, cols,CV_8UC3);
		Mat imgN(rows, cols,CV_8UC3);
		
		int iOff = 0;
		int jOff = 0;
		int matchCount = 0;
		float minDist = 512*3;
		int blockSize = 40;
		int Wind = 200;
		int s = 2;
		int jStop = (rows/s + Wind);
		int iStop = (cols/s + Wind);
		int jStart = (rows/s - Wind);
		int iStart = (cols/s - Wind);
		int jRef = (jStart + jStop)/2;
		int iRef = (iStart + iStop)/2;
		
		cout << "jStart " << jStart << " iStart " << iStart << endl;
		cout << "jRef " << jRef << " iRef " << iRef << endl;
		cout << "jStop " << jStop << " iStop " << iStop << endl;
		
		//Use a patch of 20 from the next image
		for(int j = jStart+Wind; j < jStop ; j++){
			for(int i = iStart+Wind; i < iStop ; i++){
			
				float dist = 0;
				//cout << "x ";
				//Compute all four directions starting from center of the search window.
				for(int jT = j-blockSize/2, jR = (jRef-blockSize/2); jT < (jRef+blockSize/2) ; jR++, jT++){
					for(int iT = i-blockSize/2, iR = (iRef-blockSize/2); iT < (iRef+blockSize/2) ; iR++, iT++){
						dist += abs((int)imgPrevPtr[chans*(jR*cols+iR)+0] - (int)imgNextPtr[chans*(jT*cols+iT)+0]);
						dist += abs((int)imgPrevPtr[chans*(jR*cols+iR)+1] - (int)imgNextPtr[chans*(jT*cols+iT)+1]);
						dist += abs((int)imgPrevPtr[chans*(jR*cols+iR)+2] - (int)imgNextPtr[chans*(jT*cols+iT)+2]);
					}
				}
				//cout << dist << endl; 
				if(dist <= minDist){
					minDist = dist;
					jOff += (j-jRef);
					iOff += (i-iRef);
					matchCount++;
					//cout << "Found one! dist " << dist << endl;
				}
				
			}
			//cout << endl;
		}
		
		//Use a patch of 20 from the next image
		for(int j = jStart+Wind-1; j >= jStart ; j--){
			for(int i = iStart+Wind; i < iStop ; i++){
			
				float dist = 0;
				//cout << "x ";
				//Compute all four directions starting from center of the search window.
				for(int jT = j-blockSize/2, jR = (jRef-blockSize/2); jT < (jRef+blockSize/2) ; jR++, jT++){
					for(int iT = i-blockSize/2, iR = (iRef-blockSize/2); iT < (iRef+blockSize/2) ; iR++, iT++){
						dist += abs((int)imgPrevPtr[chans*(jR*cols+iR)+0] - (int)imgNextPtr[chans*(jT*cols+iT)+0]);
						dist += abs((int)imgPrevPtr[chans*(jR*cols+iR)+1] - (int)imgNextPtr[chans*(jT*cols+iT)+1]);
						dist += abs((int)imgPrevPtr[chans*(jR*cols+iR)+2] - (int)imgNextPtr[chans*(jT*cols+iT)+2]);
					}
					//cout << dist << endl; 
					if(dist <= minDist){
						minDist = dist;
						jOff += (j-jRef);
						iOff += (i-iRef);
						matchCount++;
						//cout << "Found one! dist " << dist << endl;
					}
				}
				
			}
			//cout << endl;
		}
		
		//Use a patch of 20 from the next image
		for(int j = jStart+Wind; j < jStop ; j++){
			for(int i = iStart+Wind-1; i >= iStart ; i--){
			
				float dist = 0;
				//cout << "y ";
				//Compute all four directions starting from center of the search window.
				for(int jT = j-blockSize/2, jR = (jRef-blockSize/2); jT < (jRef+blockSize/2) ; jR++, jT++){
					for(int iT = i-blockSize/2, iR = (iRef-blockSize/2); iT < (iRef+blockSize/2) ; iR++, iT++){
						dist += abs((int)imgPrevPtr[chans*(jR*cols+iR)+0] - (int)imgNextPtr[chans*(jT*cols+iT)+0]);
						dist += abs((int)imgPrevPtr[chans*(jR*cols+iR)+1] - (int)imgNextPtr[chans*(jT*cols+iT)+1]);
						dist += abs((int)imgPrevPtr[chans*(jR*cols+iR)+2] - (int)imgNextPtr[chans*(jT*cols+iT)+2]);
				
					}
				}
				if(dist <= minDist){
					minDist = dist;
					jOff += (j-jRef);
					iOff += (i-iRef);
					matchCount++;
					//cout << "Found one! dist " << dist << endl;
				}
				
			}
			//cout << endl;
		}
		
		//Use a patch of 20 from the next image
		for(int j = jStart+Wind-1; j >= jStart ; j--){
			for(int i = iStart+Wind-1; i >= iStart ; i--){
			
				float dist = 0;
				//cout << "z ";
				//Compute all four directions starting from center of the search window.
				for(int jT = j-blockSize/2, jR = (jRef-blockSize/2); jT < (jRef+blockSize/2) ; jR++, jT++){
					for(int iT = i-blockSize/2, iR = (iRef-blockSize/2); iT < (iRef+blockSize/2) ; iR++, iT++){
						dist += abs((int)imgPrevPtr[chans*(jR*cols+iR)+0] - (int)imgNextPtr[chans*(jT*cols+iT)+0]);
						dist += abs((int)imgPrevPtr[chans*(jR*cols+iR)+1] - (int)imgNextPtr[chans*(jT*cols+iT)+1]);
						dist += abs((int)imgPrevPtr[chans*(jR*cols+iR)+2] - (int)imgNextPtr[chans*(jT*cols+iT)+2]);
					}
				}
				if(dist <= minDist){
						minDist = dist;
						jOff += (j-jRef);
						iOff += (i-iRef);
						matchCount++;
						//cout << "Found one! dist " << dist << endl;
				}
				
			}
			//cout << endl;
		}
		
		jOff/=matchCount;
		iOff/=matchCount;
		plot(imgPrevUnAlligned,iRef,jRef,0,255,0);
		plot(imgPrevUnAlligned,iRef+iOff,jRef+jOff,0,0,255);
		cout << "jOff " << jOff << " iOff " << iOff << endl; 
		imgPrev.data = imgP.data;
		imgNext.data = imgN.data;
}
	
int main()
{
	
	int N = 2;
	Mat imageStack[N];
	Mat grayStack[N];
	Mat focal_Measure[N];
	

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
		sprintf(buffer,"align/img%d.jpg",i+1);
		imageStack[i] = imread(buffer);
		
		
		if(!imageStack[i].data){
			cerr << "Could not open or find the image" << endl;
			exit(0);
		}
		
		if(i>0){
			Mat imgPrev;
			Mat imgNext;
			alignToPrevImage(imageStack[i-1],imageStack[i],imgPrev,imgNext);
			namedWindow("img1",CV_WINDOW_NORMAL);
			imshow("img1",imageStack[i-1]);
			namedWindow("img2",CV_WINDOW_NORMAL);
			imshow("img2",imageStack[i]);
			cvWaitKey(0);
			imageStack[i-1] = imgPrev;
			imageStack[i] = imgNext;
		}
		
	}
	
	return 0;
	for(int i = 0; i < N; i++){
		
		char buffer[50];
		sprintf(buffer,"align/img%d.jpg",i+1);
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
		

		// commented out-- Sid
		// Size ksize(9,9);
		// float sigma = 10.0;
		// Mat modLapSmooth;
		// GaussianBlur(modLaplacian,modLapSmooth,ksize,sigma);

		

		//siddhartha - 2-May

		//locally boosting all pixel intensities based on a 3X3 neighborhood
		Mat boosted;
		filter2D(modLaplacian, boosted, -1, boostingFilter);

		
		//averaging values of the focal measure: average filter preferred ouver gaussian filter as gaussian does not resolve the issue of noisy patches
		Size ksize(19,19);
		Mat modLapSmooth;
		boxFilter(boosted,modLapSmooth,-1,ksize);
		

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
	  		focusMap.at<uchar>(y,x)=maxK;		//TODO take out this scale factor. For visialization and debug	
	  	}
			
 	}

 	//commenting out- Sid ; taken care of smoothing by forming modLapsmooth
	//Focus does not change rapidly among objects. 
	//Smooth it!
	// Size ksize(9,9);
	// float sigma = 12.0;
	// Mat focusMapSmooth;
	// GaussianBlur(focusMap,focusMapSmooth,ksize,sigma);
	
	namedWindow("focusMap",WINDOW_AUTOSIZE);
	imshow("focusMap",focusMap);
	waitKey(0);

	namedWindow("result",WINDOW_AUTOSIZE);
	setMouseCallback("result", CallBackFunc, NULL);
	imshow("result",imageStack[0]);

	int previos=0;
	int current=0;
	int step;
	int i;
	//press ctrl+ mouse click to exit
	while(1)
	{
		while (x_coord == -1 && y_coord == -1) cvWaitKey(100); 

		if(x_coord==0)
			return 0;
	
		cout<<"coords found:  "<<endl<<x_coord<<endl<<y_coord<<endl;
		current=focusMap.at<uchar>(y_coord,x_coord);
		
		step=current-previos;

		if(step<1)
		{
			for(i=previos; i>=current;i--)
			{
				imshow("result",imageStack[i]);	
				cvWaitKey(2);
			}
			
		}
			
		else
		{
			for(i=previos; i<=current; i++)
			{
				imshow("result",imageStack[i]);	
				cvWaitKey(2);
			}
			
			
		}
			

		cout<<endl<<step<<endl;

		


		previos=current;

		
		x_coord=-1;
		y_coord =-1;	
		while (x_coord == -1 && y_coord == -1) cvWaitKey(100); 
	}

	return 0;
}
