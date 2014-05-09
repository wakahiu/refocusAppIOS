//
//  imageStack.h
//  AVCam
//
//  Created by Siddhartha Chandra on 5/8/14.
//  Copyright (c) 2014 Apple Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface imageStack : NSObject

@property (nonatomic,retain) NSMutableArray *focalStack;

+(id) sharedInstance;

@end
