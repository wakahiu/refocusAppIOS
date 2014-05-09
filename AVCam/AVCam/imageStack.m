//
//  imageStack.m
//  AVCam
//
//  Created by Siddhartha Chandra on 5/8/14.
//  Copyright (c) 2014 Apple Inc. All rights reserved.
//

#import "imageStack.h"

@implementation imageStack

@synthesize focalStack;

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
        focalStack = [[NSMutableArray alloc] init];
    }
    return self;
}

@end
