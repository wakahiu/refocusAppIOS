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
    
    int previous=0;
    
    //UIImage* displayed = [[[imageStack sharedInstance] focalStackUImage] objectAtIndex:0];
    UIImage* displayed = [[[imageStack sharedInstance] trialStack] objectAtIndex:0];
    _displayImage.image = displayed;
    
    
    
    
    
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
    
    NSLog(@"pointx %f and point y%f", point.x,point.y);
    //CGPoint topLeft = [self.layer captureDevicePointOfInterestForPoint:point];

    //CGPoint devicePoint = [(AVCaptureVideoPreviewLayer *)[[self previewView] layer] captureDevicePointOfInterestForPoint:[gestureRecognizer locationInView:[gestureRecognizer view]]];
    
    
    CGImageRef image = [[[[imageStack sharedInstance] trialStack] objectAtIndex:25] CGImage];
    //CGImageRef image = [[[[imageStack sharedInstance] focalStackUImage] objectAtIndex:9] CGImage];
    
    CFDataRef data = CGDataProviderCopyData(CGImageGetDataProvider(image));
    UInt8 * buf = (UInt8 *) CFDataGetBytePtr(data);
    int length = CFDataGetLength(data);
    
    size_t w = CGImageGetWidth(image);
    size_t row = CGImageGetBytesPerRow(image);
    //size_t h = CGImageGetHeight(image);
    
    int x=lroundf(point.x);
    int y=lroundf(point.y);
    
    int index = buf[lround(buf[x]*row + y)];
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
            //[NSThread sleepForTimeInterval:.5];
            
            
            
            [UIView transitionWithView:self.view
                              duration:0.63f
                               options:UIViewAnimationOptionTransitionCrossDissolve
                            animations:^{
                                self.displayImage.image = [[[imageStack sharedInstance] trialStack] objectAtIndex:i];
                            } completion:NULL];
            
            //_displayImage.image = [[[imageStack sharedInstance] trialStack] objectAtIndex:i];
            
            
            
            
            //_displayImage.image = [[[imageStack sharedInstance] focalStackUImage] objectAtIndex:i];
        }
        
    }
    
    else
    {
        for(int i=previous; i<=current; i++)
        {
            //[NSThread sleepForTimeInterval:.5];
            //_displayImage.image = [[[imageStack sharedInstance] trialStack] objectAtIndex:i];
            //_displayImage.image = [[[imageStack sharedInstance] focalStackUImage] objectAtIndex:i];
            
            [UIView transitionWithView:self.view
                              duration:0.63f
                               options:UIViewAnimationOptionTransitionCrossDissolve
                            animations:^{
                                self.displayImage.image = [[[imageStack sharedInstance] trialStack] objectAtIndex:i];
                            } completion:NULL];
            

        }
        
    
    
    }
    previous=current;
    //_displayImage.image = [[[imageStack sharedInstance] trialStack] objectAtIndex:index];
    //NSLog(@"index %d",index );
}
@end
