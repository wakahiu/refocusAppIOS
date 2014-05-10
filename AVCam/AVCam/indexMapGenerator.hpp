//
//  indexMapGenerator.h
//  AVCam
//
//  Created by Siddhartha Chandra on 5/8/14.
//  Copyright (c) 2014 Apple Inc. All rights reserved.
//

#ifndef __AVCam__indexMapGenerator__
#define __AVCam__indexMapGenerator__

#include "opencv2/core/core.hpp"
#include "opencv2/imgproc/imgproc.hpp"
#include <iostream>
#include <vector>

using namespace cv;

class indexMapGenerator
{
public:
    
    
    //Sid
    static Mat toGray(Mat img);
    static Mat generateFocalIndexMap(vector<Mat> imageStack);
    static Mat lap_dir(Mat img, int direction);
//    static int find


};



#endif /* defined(__AVCam__indexMapGenerator__) */
