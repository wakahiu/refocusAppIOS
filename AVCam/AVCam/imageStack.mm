//
//  imageStack.m
//  AVCam
//
//  Created by Siddhartha Chandra on 5/8/14.
//  Copyright (c) 2014 Apple Inc. All rights reserved.
//

#import "imageStack.h"
#import "UIImage+OpenCV.h"

@implementation imageStack

@synthesize focalStackUImage;
//@synthesize focalStackCvMat;

+ (id)sharedInstance {
    static imageStack *sharedMyInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyInstance = [[self alloc] init];
    });
    return sharedMyInstance;
}

- (id)init {
    if (self = [super init]) {
        focalStackUImage = [[NSMutableArray alloc] init];
        
//        NSString* filePath = [[NSBundle mainBundle]
//                              pathForResource:@"lena" ofType:@"jpg"];
//        UIImage* image = [UIImage imageWithContentsOfFile:filePath];
//        
//        cv::Mat tempMat = [image CVMat];
//        //cv::Mat *pointer = (cv::Mat *)tempMat;
//        id object = [NSValue valueWithPointer:&tempMat];
        //focalStackCvMat = [[NSMutableArray alloc] init];
    }
    return self;
}

@end




