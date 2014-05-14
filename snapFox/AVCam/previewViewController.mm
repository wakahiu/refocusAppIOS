//
//  previewViewController.m
//  snapFox
//
//  Created by Siddhartha Chandra on 5/10/14.
//  Copyright (c) 2014 Apple Inc. All rights reserved.
//

#import "previewViewController.h"
#import "imageStack.h"

@interface previewViewController ()
- (IBAction)findIndex:(UITapGestureRecognizer *)recognize;
@property (weak, nonatomic) IBOutlet UIButton *homeButton;
- (IBAction)homeButtonAction:(id)sender;


@end

@implementation previewViewController

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
    
    //NSString* filePath = [[NSBundle mainBundle]
      //                    pathForResource:@"lena" ofType:@"jpg"];
    

    //[recognize setDelegate:self];
    
    //int previous=0;
    
    UIImage* displayed = [[[imageStack sharedInstance] focalStackUImage] objectAtIndex:0];
    //UIImage* displayed = [[[imageStack sharedInstance] trialStack] objectAtIndex:0];
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
    
    NSInteger count=[[[imageStack sharedInstance] focalStackUImage] count];
    
    CGImageRef image = [[[[imageStack sharedInstance] focalStackUImage] objectAtIndex:count-1] CGImage];
    
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
    
    float display_origin_x = _displayImage.frame.origin.x;
    float display_origin_y = _displayImage.frame.origin.y;
    
    
    float display_height= _displayImage.frame.size.height;
    float display_width= _displayImage.frame.size.width;
    
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
                                //self.displayImage.image = [[[imageStack sharedInstance] trialStack] objectAtIndex:i];
                                self.displayImage.image = [[[imageStack sharedInstance] focalStackUImage] objectAtIndex:i];
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
                                //self.displayImage.image = [[[imageStack sharedInstance] trialStack] objectAtIndex:i];
                                self.displayImage.image = [[[imageStack sharedInstance] focalStackUImage] objectAtIndex:i];
                            } completion:NULL];
            

        }
        
    
    
    }
    previous=current;
    //_displayImage.image = [[[imageStack sharedInstance] trialStack] objectAtIndex:index];
    //NSLog(@"index %d",index );
}
- (IBAction)homeButtonAction:(id)sender {
    
    extern int previous;
    previous=0;
    [[[imageStack sharedInstance] focalStackUImage] removeAllObjects];
}
@end
