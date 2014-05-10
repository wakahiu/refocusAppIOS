//
//  previewViewController.m
//  AVCam
//
//  Created by Siddhartha Chandra on 5/9/14.
//  Copyright (c) 2014 Apple Inc. All rights reserved.
//

#import "previewViewController.h"

#import "imageStack.h"
#import <AVFoundation/AVFoundation.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import "AVCamPreviewView.h"
#import "UIImage+OpenCV.h"
#import "indexMapGenerator.hpp"



@interface previewViewController ()

@end



@implementation previewViewController



@synthesize imageDisplay;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSString* filePath = [[NSBundle mainBundle]
                          pathForResource:@"lena" ofType:@"jpg"];
    
    UIImage* lena_image = [UIImage imageWithContentsOfFile:filePath];
    imageDisplay.image = lena_image;
    //imageDisplay.image = [[[imageStack sharedInstance] trialStack] objectAtIndex:2];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
