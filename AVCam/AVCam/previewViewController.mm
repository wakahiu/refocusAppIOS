//
//  previewViewController.m
//  AVCam
//
//  Created by Siddhartha Chandra on 5/10/14.
//  Copyright (c) 2014 Apple Inc. All rights reserved.
//

#import "previewViewController.h"
#import "imageStack.h"

@interface previewViewController ()
- (IBAction)findIndex:(UITapGestureRecognizer *)recognize;


@end

@implementation previewViewController

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
    
    //NSString* filePath = [[NSBundle mainBundle]
      //                    pathForResource:@"lena" ofType:@"jpg"];
    

    //[recognize setDelegate:self];
    
    
    
    UIImage* focalIndex = [[[imageStack sharedInstance] trialStack] objectAtIndex:25];
    
    _displayImage.image = focalIndex;
    
    CGImageRef image = [focalIndex CGImage];
    
//    CFDataRef data = CGDataProviderCopyData(CGImageGetDataProvider(image));
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


- (IBAction)findIndex:(UITapGestureRecognizer *)recognize {
    NSLog(@"reached");
    
    
    
    CGPoint point = [recognize locationInView:self.view];
    //CGPoint topLeft = [self.layer captureDevicePointOfInterestForPoint:point];

    //CGPoint devicePoint = [(AVCaptureVideoPreviewLayer *)[[self previewView] layer] captureDevicePointOfInterestForPoint:[gestureRecognizer locationInView:[gestureRecognizer view]]];
    
    
    NSLog(@"x = %f y = %f", point.x, point.y );
}
@end
