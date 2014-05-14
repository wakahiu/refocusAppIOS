//
//  viewViewController.m
//  snapFox
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


- (IBAction)findIndex:(UITapGestureRecognizer *)recognize;

@property (weak, nonatomic) IBOutlet UIImageView *displayedImage;

@property (weak, nonatomic) IBOutlet UIButton *backButton;

@property (weak, nonatomic) IBOutlet UIButton *onBackPress;

@property (nonatomic) dispatch_queue_t sessionQueue;

@end

@implementation viewViewController



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
    
   
    UIImage* displayed = [[[imageStack sharedInstance] trialStack] objectAtIndex:0];
    _displayedImage.image = displayed;
    
    //creates an alternate queue
	dispatch_queue_t sessionQueue = dispatch_queue_create("session queue", DISPATCH_QUEUE_SERIAL);
	[self setSessionQueue:sessionQueue];
    

    
    //dispatch_async([self sessionQueue], ^{
    vector<Mat> focalStackCvMatTrial;
    
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
    //});

    
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

- (IBAction)findIndex:(UITapGestureRecognizer *)recognize {
    NSLog(@"reached");
    
    
    
    CGPoint point = [recognize locationInView:self.view];
    
    NSLog(@"pointx %f and point y%f", point.x,point.y);
    //CGPoint topLeft = [self.layer captureDevicePointOfInterestForPoint:point];
    
    //CGPoint devicePoint = [(AVCaptureVideoPreviewLayer *)[[self previewView] layer] captureDevicePointOfInterestForPoint:[gestureRecognizer locationInView:[gestureRecognizer view]]];
    
    NSInteger count=[[[imageStack sharedInstance] trialStack] count];
    CGImageRef image = [[[[imageStack sharedInstance] trialStack] objectAtIndex:count-1] CGImage];
    
    CFDataRef data = CGDataProviderCopyData(CGImageGetDataProvider(image));
    UInt8 * buf = (UInt8 *) CFDataGetBytePtr(data);
    //int length = CFDataGetLength(data);
    
    size_t w = CGImageGetWidth(image); // w-->860
    size_t row = CGImageGetBytesPerRow(image);
    size_t h = CGImageGetHeight(image); //h-> 690
    
    //y: 0- 373 (downwards from; matlab origin, irrespective of orientation)
    //x: 0- 320 (right , from top left;matlab origin, irrespective of orientation)
    float x=lroundf(point.x);
    float y=lroundf(point.y);
    
    //Actual UIImage container dimensions on device
    
    
    //change get frame.origin.x and frame.origin.y
    
    float display_origin_x = _displayedImage.frame.origin.x;
    float display_origin_y = _displayedImage.frame.origin.y;
    
    
    float display_height= _displayedImage.frame.size.height;
    float display_width= _displayedImage.frame.size.width;
    
    float rel_x= (x-display_origin_x)/display_width;
    float rel_y = (y-display_origin_y)/display_height;
    
    float actual_x = rel_x * w;
    float actual_y = rel_y * h;
    
    int index = buf[lround(actual_y*row + actual_x)]/10;
    //    for(int i=0; i<length; i+=4)
    //    {
    //        int r = buf[i];
    //        int g = buf[i+1];
    //        int b = buf[i+2];
    //        NSLog(@"red %d", r);
    //        NSLog(@"green %d", g);
    //        NSLog(@"blue %d", b);
    //    }
    CFRelease(data);
    
    
    //    Begin transition effect
    int step;
    int current = 0;
    extern int previous;
    current= index;
    step=current-previous;
    
    
    if(step<1)
    {
        for(int i=previous; i>=current;i--)
        {
            
            [UIView transitionWithView:self.view
                              duration:0.83f
                               options:UIViewAnimationOptionTransitionCrossDissolve
                            animations:^{
                                self.displayedImage.image = [[[imageStack sharedInstance] trialStack] objectAtIndex:i];
                                
                            } completion:NULL];
            
        }
        
    }
    
    else
    {
        for(int i=previous; i<=current; i++)
        {
            
            [UIView transitionWithView:self.view
                              duration:0.83f
                               options:UIViewAnimationOptionTransitionCrossDissolve
                            animations:^{
                                self.displayedImage.image = [[[imageStack sharedInstance] trialStack] objectAtIndex:i];
                                
                            } completion:NULL];
            
            
        }
        
        
        
    }
    previous=current;
    //_displayImage.image = [[[imageStack sharedInstance] trialStack] objectAtIndex:index];
    //NSLog(@"index %d",index );
}
- (IBAction)backButtonPush:(id)sender {
    
        extern int previous;
    previous=0;
      [[[imageStack sharedInstance] trialStack] removeAllObjects];
}
@end
