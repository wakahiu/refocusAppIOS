//
//  previewViewController.h
//  snapFox
//
//  Created by Siddhartha Chandra on 5/10/14.
//  Copyright (c) 2014 Apple Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^SaveImageCompletion)(NSError* error);

@interface previewViewController : UIViewController

-(void)addAssetURL:(NSURL*)assetURL toAlbum:(NSString*)albumName withCompletionBlock:(SaveImageCompletion)completionBlock;
@property (strong, nonatomic) IBOutlet UIImageView *displayImage;

@end
