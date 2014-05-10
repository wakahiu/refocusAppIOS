/*
     File: AVCamViewController.m
 Abstract: View controller for camera interface.
  Version: 3.1
 
 Disclaimer: IMPORTANT:  This Apple software is supplied to you by Apple
 Inc. ("Apple") in consideration of your agreement to the following
 terms, and your use, installation, modification or redistribution of
 this Apple software constitutes acceptance of these terms.  If you do
 not agree with these terms, please do not use, install, modify or
 redistribute this Apple software.
 
 In consideration of your agreement to abide by the following terms, and
 subject to these terms, Apple grants you a personal, non-exclusive
 license, under Apple's copyrights in this original Apple software (the
 "Apple Software"), to use, reproduce, modify and redistribute the Apple
 Software, with or without modifications, in source and/or binary forms;
 provided that if you redistribute the Apple Software in its entirety and
 without modifications, you must retain this notice and the following
 text and disclaimers in all such redistributions of the Apple Software.
 Neither the name, trademarks, service marks or logos of Apple Inc. may
 be used to endorse or promote products derived from the Apple Software
 without specific prior written permission from Apple.  Except as
 expressly stated in this notice, no other rights or licenses, express or
 implied, are granted by Apple herein, including but not limited to any
 patent rights that may be infringed by your derivative works or by other
 works in which the Apple Software may be incorporated.
 
 The Apple Software is provided by Apple on an "AS IS" basis.  APPLE
 MAKES NO WARRANTIES, EXPRESS OR IMPLIED, INCLUDING WITHOUT LIMITATION
 THE IMPLIED WARRANTIES OF NON-INFRINGEMENT, MERCHANTABILITY AND FITNESS
 FOR A PARTICULAR PURPOSE, REGARDING THE APPLE SOFTWARE OR ITS USE AND
 OPERATION ALONE OR IN COMBINATION WITH YOUR PRODUCTS.
 
 IN NO EVENT SHALL APPLE BE LIABLE FOR ANY SPECIAL, INDIRECT, INCIDENTAL
 OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
 SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
 INTERRUPTION) ARISING IN ANY WAY OUT OF THE USE, REPRODUCTION,
 MODIFICATION AND/OR DISTRIBUTION OF THE APPLE SOFTWARE, HOWEVER CAUSED
 AND WHETHER UNDER THEORY OF CONTRACT, TORT (INCLUDING NEGLIGENCE),
 STRICT LIABILITY OR OTHERWISE, EVEN IF APPLE HAS BEEN ADVISED OF THE
 POSSIBILITY OF SUCH DAMAGE.
 
 Copyright (C) 2014 Apple Inc. All Rights Reserved.
 
 */

#import "AVCamViewController.h"
#import "imageStack.h"
#import <AVFoundation/AVFoundation.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import "AVCamPreviewView.h"

#import "UIImage+OpenCV.h"
#import "indexMapGenerator.hpp"

static void * CapturingStillImageContext = &CapturingStillImageContext;
static void * RecordingContext = &RecordingContext;
static void * SessionRunningAndDeviceAuthorizedContext = &SessionRunningAndDeviceAuthorizedContext;

@interface AVCamViewController () <AVCaptureFileOutputRecordingDelegate>

// For use in the storyboards.
@property (nonatomic, weak) IBOutlet AVCamPreviewView *previewView;
@property (nonatomic, weak) IBOutlet UIButton *stillButton;

- (IBAction)snapStillImage:(id)sender;
- (IBAction)focusAndExposeTap:(UIGestureRecognizer *)gestureRecognizer;

// Session management.
@property (nonatomic) dispatch_queue_t sessionQueue; // Communicate with the session and other session objects on this queue.
@property (nonatomic) AVCaptureSession *session;
@property (nonatomic) AVCaptureDeviceInput *videoDeviceInput;
//@property (nonatomic) AVCaptureMovieFileOutput *movieFileOutput;
@property (nonatomic) AVCaptureStillImageOutput *stillImageOutput;

// Utilities.
@property (nonatomic) UIBackgroundTaskIdentifier backgroundRecordingID;
@property (nonatomic, getter = isDeviceAuthorized) BOOL deviceAuthorized;
@property (nonatomic, readonly, getter = isSessionRunningAndDeviceAuthorized) BOOL sessionRunningAndDeviceAuthorized;
@property (nonatomic) BOOL lockInterfaceRotation;
@property (nonatomic) id runtimeErrorHandlingObserver;

@end

@implementation AVCamViewController



- (BOOL)isSessionRunningAndDeviceAuthorized
{
	return [[self session] isRunning] && [self isDeviceAuthorized];
}

+ (NSSet *)keyPathsForValuesAffectingSessionRunningAndDeviceAuthorized
{
	return [NSSet setWithObjects:@"session.running", @"deviceAuthorized", nil];
}


- (void)viewDidLoad
{
	[super viewDidLoad];
	
    //creates an album
    
    
    [[[ALAssetsLibrary alloc] init] addAssetsGroupAlbumWithName:@"new"
     
    resultBlock:^(ALAssetsGroup *group)
     {
         NSLog(@"added album");
     }
    failureBlock:^(NSError *error) {
        NSLog(@"error adding album");
    }];


	// Create the AVCaptureSession
	AVCaptureSession *session = [[AVCaptureSession alloc] init];
	[self setSession:session];
	
	// Setup the preview view
	[[self previewView] setSession:session];
	
	// Check for device authorization
	[self checkDeviceAuthorizationStatus];
	
	// In general it is not safe to mutate an AVCaptureSession or any of its inputs, outputs, or connections from multiple threads at the same time.
	// Why not do all of this on the main queue?
	// -[AVCaptureSession startRunning] is a blocking call which can take a long time. We dispatch session setup to the sessionQueue so that the main queue isn't blocked (which keeps the UI responsive).
	
    
    //creates an alternate queue
	dispatch_queue_t sessionQueue = dispatch_queue_create("session queue", DISPATCH_QUEUE_SERIAL);
	[self setSessionQueue:sessionQueue];
	
	dispatch_async(sessionQueue, ^{
		[self setBackgroundRecordingID:UIBackgroundTaskInvalid];
		
		NSError *error = nil;
		
        //sets back camera as the the capture device and device input
		AVCaptureDevice *videoDevice = [AVCamViewController deviceWithMediaType:AVMediaTypeVideo preferringPosition:AVCaptureDevicePositionBack];
		AVCaptureDeviceInput *videoDeviceInput = [AVCaptureDeviceInput deviceInputWithDevice:videoDevice error:&error];
		
		if (error)
		{
			NSLog(@"%@", error);
		}
		
		if ([session canAddInput:videoDeviceInput])
		{
			[session addInput:videoDeviceInput];
			[self setVideoDeviceInput:videoDeviceInput];

			dispatch_async(dispatch_get_main_queue(), ^{
				// Why are we dispatching this to the main queue?
				// Because AVCaptureVideoPreviewLayer is the backing layer for AVCamPreviewView and UIView can only be manipulated on main thread.
				// Note: As an exception to the above rule, it is not necessary to serialize video orientation changes on the AVCaptureVideoPreviewLayer’s connection with other session manipulation.
  
				[[(AVCaptureVideoPreviewLayer *)[[self previewView] layer] connection] setVideoOrientation:(AVCaptureVideoOrientation)[self interfaceOrientation]];
			});
		}
				
        //sets the JPEG format for image capture
		AVCaptureStillImageOutput *stillImageOutput = [[AVCaptureStillImageOutput alloc] init];
		if ([session canAddOutput:stillImageOutput])
		{
			[stillImageOutput setOutputSettings:@{AVVideoCodecKey : AVVideoCodecJPEG}];
			[session addOutput:stillImageOutput];
			[self setStillImageOutput:stillImageOutput];
		}
	});
}

- (void)viewWillAppear:(BOOL)animated
{
	dispatch_async([self sessionQueue], ^{
		[self addObserver:self forKeyPath:@"sessionRunningAndDeviceAuthorized" options:(NSKeyValueObservingOptionOld | NSKeyValueObservingOptionNew) context:SessionRunningAndDeviceAuthorizedContext];
		[self addObserver:self forKeyPath:@"stillImageOutput.capturingStillImage" options:(NSKeyValueObservingOptionOld | NSKeyValueObservingOptionNew) context:CapturingStillImageContext];
//		[self addObserver:self forKeyPath:@"movieFileOutput.recording" options:(NSKeyValueObservingOptionOld | NSKeyValueObservingOptionNew) context:RecordingContext];
//		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(subjectAreaDidChange:) name:AVCaptureDeviceSubjectAreaDidChangeNotification object:[[self videoDeviceInput] device]];
		
		__weak AVCamViewController *weakSelf = self;
		[self setRuntimeErrorHandlingObserver:[[NSNotificationCenter defaultCenter] addObserverForName:AVCaptureSessionRuntimeErrorNotification object:[self session] queue:nil usingBlock:^(NSNotification *note) {
			AVCamViewController *strongSelf = weakSelf;
			dispatch_async([strongSelf sessionQueue], ^{
				// Manually restarting the session since it must have been stopped due to an error.
				[[strongSelf session] startRunning];
				//[[strongSelf recordButton] setTitle:NSLocalizedString(@"Record", @"Recording button record title") forState:UIControlStateNormal];
			});
		}]];
		[[self session] startRunning];
	});
}

- (void)viewDidDisappear:(BOOL)animated
{
	dispatch_async([self sessionQueue], ^{
		[[self session] stopRunning];
		
		[[NSNotificationCenter defaultCenter] removeObserver:self name:AVCaptureDeviceSubjectAreaDidChangeNotification object:[[self videoDeviceInput] device]];
		[[NSNotificationCenter defaultCenter] removeObserver:[self runtimeErrorHandlingObserver]];
		
		[self removeObserver:self forKeyPath:@"sessionRunningAndDeviceAuthorized" context:SessionRunningAndDeviceAuthorizedContext];
		[self removeObserver:self forKeyPath:@"stillImageOutput.capturingStillImage" context:CapturingStillImageContext];

	});
}

- (BOOL)prefersStatusBarHidden
{
	return YES;
}

//- (BOOL)shouldAutorotate
//{
//	// Disable autorotation of the interface when recording is in progress.
//	return ![self lockInterfaceRotation];
//}

//- (NSUInteger)supportedInterfaceOrientations
//{
//	return UIInterfaceOrientationMaskAll;
//}

//not sure whether this should be kept...refocussing myt not work in landscape
- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
	[[(AVCaptureVideoPreviewLayer *)[[self previewView] layer] connection] setVideoOrientation:(AVCaptureVideoOrientation)toInterfaceOrientation];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
	if (context == CapturingStillImageContext)
	{
		BOOL isCapturingStillImage = [change[NSKeyValueChangeNewKey] boolValue];
		
		if (isCapturingStillImage)
		{
			[self runStillImageCaptureAnimation];
		}
	}

	else if (context == SessionRunningAndDeviceAuthorizedContext)
	{
		BOOL isRunning = [change[NSKeyValueChangeNewKey] boolValue];
		
		dispatch_async(dispatch_get_main_queue(), ^{
			if (isRunning)
			{
				
				[[self stillButton] setEnabled:YES];
			}
			else
			{
				
				[[self stillButton] setEnabled:NO];
			}
		});
	}
	else
	{
		[super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
	}
}

#pragma mark Actions


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



- (IBAction)snapStillImage:(id)sender
{
    
    
    _stillButton.enabled= NO;
    viewDidDisappear:(YES);
    [self performSegueWithIdentifier: @"camToPreview" sender: self];
    
//	dispatch_async([self sessionQueue], ^{
		// Update the orientation on the still image output video connection before capturing.
		[[[self stillImageOutput] connectionWithMediaType:AVMediaTypeVideo] setVideoOrientation:[[(AVCaptureVideoPreviewLayer *)[[self previewView] layer] connection] videoOrientation]];
		
		// Flash set to Auto for Still Capture ; Sid- switching flash mode off for now
		[AVCamViewController setFlashMode:AVCaptureFlashModeOff forDevice:[[self videoDeviceInput] device]];
		
		// Capture multiple images.

    //Sid - Commented for testing: Actual!
    
//        for (int i=0; i<3; i++)
//        {
//            for (int j=0; j<3; j++)
//            {
//                CGPoint devicePoint = CGPointMake(i*.33 +0.16, j*0.33+0.16);
//        
//                [self focusWithMode:AVCaptureFocusModeAutoFocus exposeWithMode:AVCaptureExposureModeAutoExpose atDevicePoint:devicePoint monitorSubjectAreaChange:YES];
//            
//                [[self stillImageOutput] captureStillImageAsynchronouslyFromConnection:[[self stillImageOutput] connectionWithMediaType:AVMediaTypeVideo] completionHandler:^(CMSampleBufferRef imageDataSampleBuffer, NSError *error) {
//                    
//                    if (imageDataSampleBuffer)
//                    {
//                
//                        //NSLog(@"entry count: %d", i);
//                        //NSLog(@"entry count: %d\n\n", j);
//                        NSData *imageData = [AVCaptureStillImageOutput jpegStillImageNSDataRepresentation:imageDataSampleBuffer];
//
//                        UIImage *image = [[UIImage alloc] initWithData:imageData];
//                        [[[imageStack sharedInstance] focalStackUImage] addObject:image];
//                    
///* SC3653 - writes file to a given folder. Commenting temporarily to check for global focal Stack */
// 
////                        [[[ALAssetsLibrary alloc] init] writeImageToSavedPhotosAlbum:[image CGImage] orientation:(ALAssetOrientation)[image imageOrientation] completionBlock:^(NSURL *assetURL, NSError *error)
////                        
////                        {
////                            if (error) {
////                                NSLog(@"error");
////                            } else {
////                                NSLog(@"url %@", assetURL);
////                                
////                                //add the asset to the custom photo album
////                                [self addAssetURL: assetURL
////                                          toAlbum:@"new"
////                                    withCompletionBlock:^(NSError *error) {
////                                  if (error!=nil) {
////                                      NSLog(@"Big error: %@", [error description]);
////                                  }
////                              }];
////                            }  
////                        }];
///**********************************************/
//                        
//                    }
//                }];
//
//
//            }
//        }

	dispatch_async([self sessionQueue], ^{
    // Sid - commented for testing: Actual
    //sleep(5);
    //NSLog(@"array contains %d objects", [[[imageStack sharedInstance] focalStackUImage]  count]);
        
        
    //cv::Mat *focalStackCvMat = new cv::Mat [[[[imageStack sharedInstance] focalStackUImage]  count]];
        
        vector<Mat> focalStackCvMat;
        
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

    for (NSInteger k=0; k< [[[imageStack sharedInstance] trialStack]  count]; k++)
    {
            UIImage *temp= [[[imageStack sharedInstance] trialStack] objectAtIndex:k];
            focalStackCvMatTrial.push_back([temp CVMat]);
            //UIImage *converted =[[UIImage alloc] initWithCVMat:focalStackCvMat[k]];
    }
        
        //Generate focalIndexStack
        Mat focalIndex;
        
        UIImage *try1 =[[UIImage alloc] initWithCVMat:focalStackCvMatTrial[0]];
        UIImage *try2 =[[UIImage alloc] initWithCVMat:focalStackCvMatTrial[5]];
        UIImage *try3 =[[UIImage alloc] initWithCVMat:focalStackCvMatTrial[10]];
        UIImage *try4 =[[UIImage alloc] initWithCVMat:focalStackCvMatTrial[15]];
        UIImage *try5 =[[UIImage alloc] initWithCVMat:focalStackCvMatTrial[20]];
        
        focalIndex= indexMapGenerator::generateFocalIndexMap(focalStackCvMatTrial);
        UIImage *converted =[[UIImage alloc] initWithCVMat:focalIndex];
        
        NSLog(@"fingers crossed! %lu", focalStackCvMat.size());
        
    /* Actual stuff - Sid ------------ */
//    for (NSInteger k=0; k< [[[imageStack sharedInstance] focalStackUImage]  count]; k++)
//    {
//        UIImage *temp= [[[imageStack sharedInstance] focalStackUImage] objectAtIndex:k];
//        focalStackCvMat.push_back([temp CVMat]);
//        //UIImage *converted =[[UIImage alloc] initWithCVMat:focalStackCvMat[k]];
//    }
        //Generate focalIndexStack
        //Mat focalIndex;
        
        //focalIndex= indexMapGenerator::generateFocalIndexMap(focalStackCvMat);
        //UIImage *converted =[[UIImage alloc] initWithCVMat:focalIndex];

        //NSLog(@"fingers crossed!");
	});
    
}



- (IBAction)focusAndExposeTap:(UIGestureRecognizer *)gestureRecognizer
{
	CGPoint devicePoint = [(AVCaptureVideoPreviewLayer *)[[self previewView] layer] captureDevicePointOfInterestForPoint:[gestureRecognizer locationInView:[gestureRecognizer view]]];
	[self focusWithMode:AVCaptureFocusModeAutoFocus exposeWithMode:AVCaptureExposureModeAutoExpose atDevicePoint:devicePoint monitorSubjectAreaChange:YES];
}

//- (void)subjectAreaDidChange:(NSNotification *)notification
//{
	//CGPoint devicePoint = CGPointMake(.5, .5);
	//[self focusWithMode:AVCaptureFocusModeContinuousAutoFocus exposeWithMode:AVCaptureExposureModeContinuousAutoExposure atDevicePoint:devicePoint monitorSubjectAreaChange:NO];
//}

#pragma mark File Output Delegate



#pragma mark Device Configuration


- (void)focusWithMode:(AVCaptureFocusMode)focusMode exposeWithMode:(AVCaptureExposureMode)exposureMode atDevicePoint:(CGPoint)point monitorSubjectAreaChange:(BOOL)monitorSubjectAreaChange
{
	//dispatch_async([self sessionQueue], ^{
		AVCaptureDevice *device = [[self videoDeviceInput] device];
		NSError *error = nil;
        

		if ([device lockForConfiguration:&error])
		{
            
            
            if ([device isExposurePointOfInterestSupported] && [device isExposureModeSupported:exposureMode])
			{
				[device setExposureMode:exposureMode];
				[device setExposurePointOfInterest:point];
                
			}

            
			if ([device isFocusPointOfInterestSupported] && [device isFocusModeSupported:focusMode])
			{

                [device setFocusPointOfInterest:point];
                [device setFocusMode:focusMode];
                //locking focus setting
                
                sleep(1);
                [device setFocusMode:AVCaptureFocusModeLocked];
                
			}
        
        
            
			[device unlockForConfiguration];
            

		}
		else
		{
			NSLog(@"%@", error);
		}
	//});
}

+ (void)setFlashMode:(AVCaptureFlashMode)flashMode forDevice:(AVCaptureDevice *)device
{
	if ([device hasFlash] && [device isFlashModeSupported:flashMode])
	{
		NSError *error = nil;
		if ([device lockForConfiguration:&error])
		{
			[device setFlashMode:flashMode];
			[device unlockForConfiguration];
		}
		else
		{
			NSLog(@"%@", error);
		}
	}
}

+ (AVCaptureDevice *)deviceWithMediaType:(NSString *)mediaType preferringPosition:(AVCaptureDevicePosition)position
{
	NSArray *devices = [AVCaptureDevice devicesWithMediaType:mediaType];
	AVCaptureDevice *captureDevice = [devices firstObject];
	
	for (AVCaptureDevice *device in devices)
	{
		if ([device position] == position)
		{
			captureDevice = device;
			break;
		}
	}
	
	return captureDevice;
}

#pragma mark UI

- (void)runStillImageCaptureAnimation
{
	dispatch_async(dispatch_get_main_queue(), ^{
		[[[self previewView] layer] setOpacity:0.0];
		[UIView animateWithDuration:.25 animations:^{
			[[[self previewView] layer] setOpacity:1.0];
		}];
        
	});
}

- (void)checkDeviceAuthorizationStatus
{
	NSString *mediaType = AVMediaTypeVideo;
	
	[AVCaptureDevice requestAccessForMediaType:mediaType completionHandler:^(BOOL granted) {
		if (granted)
		{
			//Granted access to mediaType
			[self setDeviceAuthorized:YES];
		}
		else
		{
			//Not granted access to mediaType
			dispatch_async(dispatch_get_main_queue(), ^{
				[[[UIAlertView alloc] initWithTitle:@"AVCam!"
											message:@"AVCam doesn't have permission to use Camera, please change privacy settings"
										   delegate:self
								  cancelButtonTitle:@"OK"
								  otherButtonTitles:nil] show];
				[self setDeviceAuthorized:NO];
			});
		}
	}];
}

@end
