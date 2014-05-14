//
//  previewViewController.m
//  snapFox
//
//  Created by Siddhartha Chandra on 5/10/14.
//  Copyright (c) 2014 Apple Inc. All rights reserved.
//

#import "previewViewController.h"
#import "imageStack.h"
#import <AssetsLibrary/AssetsLibrary.h>

@interface previewViewController ()
- (IBAction)findIndex:(UITapGestureRecognizer *)recognize;
@property (weak, nonatomic) IBOutlet UIButton *homeButton;
- (IBAction)homeButtonAction:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *saveButton;
- (IBAction)onSave:(id)sender;

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

-(void)addAssetURL:(NSURL*)assetURL toAlbum:(NSString*)albumName withCompletionBlock:(SaveImageCompletion)completionBlock
{
    __block BOOL albumWasFound = NO;
    
    ALAssetsLibrary *library= [[ALAssetsLibrary alloc] init];
    
    //search all photo albums in the library
    [library enumerateGroupsWithTypes:ALAssetsGroupAlbum
                           usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
                               
                               //compare the names of the albums
                               if ([albumName compare: [group valueForProperty:ALAssetsGroupPropertyName]]==NSOrderedSame) {
                                   
                                   //target album is found
                                   albumWasFound = YES;
                                   
                                   //get a hold of the photo's asset instance
                                   [library assetForURL: assetURL
                                            resultBlock:^(ALAsset *asset) {
                                                
                                                //add photo to the target album
                                                [group addAsset: asset];
                                                
                                                //run the completion block
                                                completionBlock(nil);
                                                
                                            } failureBlock: completionBlock];
                                   
                                   //album was found, bail out of the method
                                   return;
                               }
                               
                               if (group==nil && albumWasFound==NO) {
                                   //photo albums are over, target album does not exist, thus create it
                                   
                                   __weak ALAssetsLibrary* weakSelf = library;
                                   
                                   //create new assets album
                                   [library addAssetsGroupAlbumWithName:albumName
                                                            resultBlock:^(ALAssetsGroup *group) {
                                                                
                                                                //get the photo's instance
                                                                [weakSelf assetForURL: assetURL
                                                                          resultBlock:^(ALAsset *asset) {
                                                                              
                                                                              //add photo to the newly created album
                                                                              [group addAsset: asset];
                                                                              
                                                                              //call the completion block
                                                                              completionBlock(nil);
                                                                              
                                                                          } failureBlock: completionBlock];
                                                                
                                                            } failureBlock: completionBlock];
                                   
                                   //should be the last iteration anyway, but just in case
                                   return;
                               }
                               
                           } failureBlock: completionBlock];
    
}


- (IBAction)onSave:(id)sender {
    
    
    extern int sampleCount;
    
    NSString *location = @"sample";
    location = [NSString stringWithFormat:@"%@%i", location, sampleCount];
    
    [[[ALAssetsLibrary alloc] init] addAssetsGroupAlbumWithName:location
     
                                                    resultBlock:^(ALAssetsGroup *group)
     {
         NSLog(@"added album");
     }
                                                   failureBlock:^(NSError *error) {
                                                       NSLog(@"error adding album");
                                                   }];
    

 
    
    int i=0;
    int count = [[[imageStack sharedInstance] focalStackUImage] count];
    for (i=0; i<count;i++)
    {
        /* SC3653 - writes file to a given folder. Commenting temporarily to check for global focal Stack */
        
        UIImage *temp= [[[imageStack sharedInstance] focalStackUImage] objectAtIndex:i];
        
        [[[ALAssetsLibrary alloc] init] writeImageToSavedPhotosAlbum:[temp CGImage] orientation:(ALAssetOrientation)[temp imageOrientation] completionBlock:^(NSURL *assetURL, NSError *error)
         
                                 {
                                     if (error) {
                                         NSLog(@"error");
                                     } else {
                                         NSLog(@"url %@", assetURL);
         
                                         //add the asset to the custom photo album
                                         [self addAssetURL: assetURL
                                                   toAlbum:location
                                             withCompletionBlock:^(NSError *error) {
                                           if (error!=nil) {
                                               NSLog(@"Big error: %@", [error description]);
                                           }
                                       }];
                                     }
                                 }];

    }
    
    sampleCount=sampleCount+1;
    [_homeButton sendActionsForControlEvents: UIControlEventTouchUpInside];
   }
@end
