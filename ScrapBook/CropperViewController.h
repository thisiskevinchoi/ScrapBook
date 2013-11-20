//
//  CropperViewController.h
//  ScrapBook
//
//  Created by Kevin Choi on 10/28/13.
//  Copyright (c) 2013 Kevin Choi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CropRegionView.h"

@interface CropperViewController : UIViewController

@property UIImageView *mainImageView;
@property UIImageView *croppedImageView;

@property UIImage *origImage;

@property UIButton *saveButton;
@property UIButton *origButton;
@property UIButton *sepiaButton;
@property UIButton *posterizeButton;
@property UIButton *negativeButton;

@property id target;
@property SEL action;

@property CropRegionView *cropper;
@property UITapGestureRecognizer *doubleTabRecognizer;

- (void)cropImageAndSendToTarget;
- (void)setImage:(UIImage *)newImage;

@end
