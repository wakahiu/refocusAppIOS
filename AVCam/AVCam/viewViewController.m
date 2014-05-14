//
//  viewViewController.m
//  AVCam
//
//  Created by Siddhartha Chandra on 5/13/14.
//  Copyright (c) 2014 Apple Inc. All rights reserved.
//

#import "viewViewController.h"
#import "AVCamViewController.h"
#import "imageStack.h"
#import "UIImage+OpenCV.h"


#import <AssetsLibrary/AssetsLibrary.h>
#import "AVCamPreviewView.h"
#import "indexMapGenerator.hpp"

@interface viewViewController ()



@property (weak, nonatomic) IBOutlet UIImageView *displayedImage;

@end

@implementation viewViewController




- (IBAction)backButton:(id)sender {
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (BOOL)shouldAutorotate {
    return NO;
}


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
    //vector<Mat> focalStackCvMat;
    
    //trial----------------test

    vector<Mat> focalStackCvMatTrial;
    
    
    NSString* filePath1= [[NSBundle mainBundle] pathForResource:@"frame1" ofType:@"jpg"];
    
    NSString* filePath2= [[NSBundle mainBundle] pathForResource:@"frame2" ofType:@"jpg"];
    
    NSString* filePath3= [[NSBundle mainBundle] pathForResource:@"frame3" ofType:@"jpg"];
    
    NSString* filePath4= [[NSBundle mainBundle] pathForResource:@"frame4" ofType:@"jpg"];
    
    NSString* filePath5= [[NSBundle mainBundle] pathForResource:@"frame5" ofType:@"jpg" ];
    
    NSString* filePath6= [[NSBundle mainBundle] pathForResource:@"frame6" ofType:@"jpg" ];
    
    NSString* filePath7= [[NSBundle mainBundle] pathForResource:@"frame7" ofType:@"jpg" ];
    
    NSString* filePath8= [[NSBundle mainBundle] pathForResource:@"frame8" ofType:@"jpg" ];
    
    NSString* filePath9= [[NSBundle mainBundle] pathForResource:@"frame9" ofType:@"jpg" ];
    
    NSString* filePath10= [[NSBundle mainBundle] pathForResource:@"frame10" ofType:@"jpg" ];
    
    NSString* filePath11= [[NSBundle mainBundle] pathForResource:@"frame11" ofType:@"jpg" ];
    
    NSString* filePath12= [[NSBundle mainBundle] pathForResource:@"frame12" ofType:@"jpg" ];
    
    NSString* filePath13= [[NSBundle mainBundle] pathForResource:@"frame13" ofType:@"jpg" ];
    
    NSString* filePath14= [[NSBundle mainBundle] pathForResource:@"frame14" ofType:@"jpg" ];
    
    NSString* filePath15= [[NSBundle mainBundle] pathForResource:@"frame15" ofType:@"jpg" ];
    
    NSString* filePath16= [[NSBundle mainBundle] pathForResource:@"frame16" ofType:@"jpg" ];
    
    NSString* filePath17= [[NSBundle mainBundle] pathForResource:@"frame17" ofType:@"jpg" ];
    
    NSString* filePath18= [[NSBundle mainBundle] pathForResource:@"frame18" ofType:@"jpg" ];
    
    NSString* filePath19= [[NSBundle mainBundle] pathForResource:@"frame19" ofType:@"jpg" ];
    
    NSString* filePath20= [[NSBundle mainBundle] pathForResource:@"frame20" ofType:@"jpg" ];
    
    NSString* filePath21= [[NSBundle mainBundle] pathForResource:@"frame21" ofType:@"jpg" ];
    
    NSString* filePath22= [[NSBundle mainBundle] pathForResource:@"frame22" ofType:@"jpg" ];
    
    NSString* filePath23= [[NSBundle mainBundle] pathForResource:@"frame23" ofType:@"jpg" ];
    
    NSString* filePath24= [[NSBundle mainBundle] pathForResource:@"frame24" ofType:@"jpg" ];
    
    NSString* filePath25= [[NSBundle mainBundle] pathForResource:@"frame25" ofType:@"jpg" ];
    
    
    
    
    
    //UIImage* tr=[UIImage imageWithContentsOfFile:filePath1];
    //[trialStack addObject:tr];
    
    
    [[[imageStack sharedInstance] trialStack] removeAllObjects];
    
    
    [[[imageStack sharedInstance] trialStack] addObject:[UIImage imageWithContentsOfFile:filePath1]];
    [[[imageStack sharedInstance] trialStack] addObject:[UIImage imageWithContentsOfFile:filePath2]];
    
    [[[imageStack sharedInstance] trialStack] addObject:[UIImage imageWithContentsOfFile:filePath3]];
    [[[imageStack sharedInstance] trialStack] addObject:[UIImage imageWithContentsOfFile:filePath4]];
    [[[imageStack sharedInstance] trialStack] addObject:[UIImage imageWithContentsOfFile:filePath5]];
    [[[imageStack sharedInstance] trialStack] addObject:[UIImage imageWithContentsOfFile:filePath6]];
    [[[imageStack sharedInstance] trialStack] addObject:[UIImage imageWithContentsOfFile:filePath7]];
    [[[imageStack sharedInstance] trialStack] addObject:[UIImage imageWithContentsOfFile:filePath8]];
    [[[imageStack sharedInstance] trialStack] addObject:[UIImage imageWithContentsOfFile:filePath9]];
    [[[imageStack sharedInstance] trialStack] addObject:[UIImage imageWithContentsOfFile:filePath10]];
    [[[imageStack sharedInstance] trialStack] addObject:[UIImage imageWithContentsOfFile:filePath11]];
    [[[imageStack sharedInstance] trialStack] addObject:[UIImage imageWithContentsOfFile:filePath12]];
    
    [[[imageStack sharedInstance] trialStack] addObject:[UIImage imageWithContentsOfFile:filePath13]];
    
    [[[imageStack sharedInstance] trialStack] addObject:[UIImage imageWithContentsOfFile:filePath14]];
    [[[imageStack sharedInstance] trialStack] addObject:[UIImage imageWithContentsOfFile:filePath15]];
    [[[imageStack sharedInstance] trialStack] addObject:[UIImage imageWithContentsOfFile:filePath16]];
    [[[imageStack sharedInstance] trialStack] addObject:[UIImage imageWithContentsOfFile:filePath17]];
    [[[imageStack sharedInstance] trialStack] addObject:[UIImage imageWithContentsOfFile:filePath18]];
    [[[imageStack sharedInstance] trialStack] addObject:[UIImage imageWithContentsOfFile:filePath19]];
    [[[imageStack sharedInstance] trialStack] addObject:[UIImage imageWithContentsOfFile:filePath20]];
    [[[imageStack sharedInstance] trialStack] addObject:[UIImage imageWithContentsOfFile:filePath21]];
    [[[imageStack sharedInstance] trialStack] addObject:[UIImage imageWithContentsOfFile:filePath22]];
    [[[imageStack sharedInstance] trialStack] addObject:[UIImage imageWithContentsOfFile:filePath23]];
    [[[imageStack sharedInstance] trialStack] addObject:[UIImage imageWithContentsOfFile:filePath24]];
    [[[imageStack sharedInstance] trialStack] addObject:[UIImage imageWithContentsOfFile:filePath25]];
    
   
    UIImage *temp= [[[imageStack sharedInstance] trialStack] objectAtIndex:0];
    
    for (NSInteger k=0; k< [[[imageStack sharedInstance] trialStack]  count]; k++)
    {
        UIImage *temp= [[[imageStack sharedInstance] trialStack] objectAtIndex:k];
        focalStackCvMatTrial.push_back([temp CVMat]);
        //UIImage *converted =[[UIImage alloc] initWithCVMat:focalStackCvMat[k]];
    }
    
    //Generate focalIndexStack
    Mat focalIndex;
    
    
    focalIndex= indexMapGenerator::generateFocalIndexMap(focalStackCvMatTrial);
    UIImage *converted =[[UIImage alloc] initWithCVMat:focalIndex];
    
    [[[imageStack sharedInstance] trialStack] addObject:converted];
    
    NSLog(@"fingers crossed! %lu", focalStackCvMatTrial.size());
    
    
    UIImage* displayed = [[[imageStack sharedInstance] trialStack] objectAtIndex:0];
    _displayedImage.image = displayed;
    
    
    
    
    
    
    
    //    const unsigned char * buffer =  CFDataGetBytePtr(data);
    NSLog(@"try");
    
    
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
