//
//  indexMapGenerator.h
//  AVCam
//
//  Created by Siddhartha Chandra on 5/8/14.
//  Copyright (c) 2014 Apple Inc. All rights reserved.
//

#ifndef __AVCam__indexMapGenerator__
#define __AVCam__indexMapGenerator__

//#include <opencv2/core/core_c.h>
#include "opencv2/core/core.hpp"
#include "opencv2/imgproc/imgproc.hpp"
#include <iostream>

class indexMapGenerator
{
public:
    
    
    struct Images
    {
        cv::Mat face;
        cv::Mat texture;
        cv::Mat text;
    };
    
    indexMapGenerator(Images images);
    void print(cv::Mat& postcard) const;
    
private:
    void crumple(cv::Mat& image, const cv::Mat& texture,
                 const cv::Mat& mask = cv::Mat()) const;
    void alphaBlend(const cv::Mat& src, cv::Mat& dst,
                    const cv::Mat& alpha) const;
    
    Images images_;
};



#endif /* defined(__AVCam__indexMapGenerator__) */
