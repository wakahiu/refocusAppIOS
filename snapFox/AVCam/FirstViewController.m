//
//  FirstViewController.m
//  snapFox
//
//  Created by Siddhartha Chandra on 5/13/14.
//  Copyright (c) 2014 Apple Inc. All rights reserved.
//

#import "FirstViewController.h"

@interface FirstViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *firstImage;
@property (weak, nonatomic) IBOutlet UIView *captureButton;
- (IBAction)onCapture:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *viewButton;
@property (weak, nonatomic) IBOutlet UIButton *onView;



@end

@implementation FirstViewController

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
    
    
//    NSString* filePath = [[NSBundle mainBundle]
//                        pathForResource:@"lena" ofType:@"jpg"];
//    UIImage *lena = [UIImage imageWithContentsOfFile:filePath];
//    
//    UIImage *imageToDisplay =    [UIImage imageWithCGImage:[lena CGImage]
//                        scale:1.0
//                  orientation: UIImageOrientationUp];
//    
//    _firstImage.image = imageToDisplay;
   
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (BOOL)shouldAutorotate {
    return NO;
}

//- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
//{
//    CGPoint centerPoint = CGPointMake(0,0);
//    //[_firstImage setCenter:centerPoint];
    //UIImage* rotatedImage = [UIImage imageWithCGImage:myImage.CGImage scale:1.0 orientation:UIImageOrientationLeft];
//}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)onCapture:(id)sender {
}
@end
