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


indexMapGenerator::indexMapGenerator(Images images)
{
    images_ = images;
}

void indexMapGenerator::print(Mat& postcard) const
{
    // Prepare postcard
    int border = 50;
    int bottomBorder = border * 4;
    cv::Size postcardSize = cv::Size(images_.face.cols + 2 * border,
                                     images_.face.rows + border + bottomBorder);
    resize(images_.texture, postcard, postcardSize);
    
    // Choose places for face and text
    cv::Point shift(border, border);
    cv::Rect faceRoi = cv::Rect(shift, images_.face.size());
    Mat placeForFace = postcard(faceRoi);
    cv::Point origin(border, images_.face.rows + border);
    cv::Rect textRoi(origin + shift, images_.text.size());
    Mat placeForText = postcard(textRoi);
    
    // Add crumpled face
    Mat crumpledFace = images_.face.clone();
    crumple(crumpledFace, placeForFace);
    crumpledFace.copyTo(placeForFace);
    
    // Get text's alpha channel
    vector<Mat> textPlanes;
    split(images_.text, textPlanes);
    Mat alpha = textPlanes[3];
    textPlanes.pop_back();
    Mat bgrText;
    merge(textPlanes, bgrText);
    
    // Add text with crumpling and alpha
    crumple(bgrText, placeForText, alpha);
    alphaBlend(bgrText, placeForText, alpha);
}

void indexMapGenerator::crumple(Mat& image, const Mat& texture,
                              const Mat& mask) const
{
    Mat relief;
    cvtColor(texture, relief, CV_BGR2GRAY);
    relief = 255 - relief;
    
    Mat hsvImage;
    vector<Mat> planes;
    cvtColor(image, hsvImage, CV_BGR2HSV);
    
    split(hsvImage, planes);
    subtract(planes[2], relief, planes[2], mask);
    merge(planes, hsvImage);
    
    cvtColor(hsvImage, image, CV_HSV2BGR);
}

void indexMapGenerator::alphaBlend(const Mat& src, Mat& dst,
                                 const Mat& alpha) const
{
    for (int i = 0; i < src.rows; i++)
        for (int j = 0; j < src.cols; j++)
        {
            uchar alpha_value = alpha.at<uchar>(i, j);
            if (alpha_value != 0)
            {
                float weight = float(alpha_value) / 255.f;
                dst.at<Vec3b>(i, j) = weight * src.at<Vec3b>(i, j) +
                (1 - weight) * dst.at<Vec3b>(i, j);
            }
        }
}