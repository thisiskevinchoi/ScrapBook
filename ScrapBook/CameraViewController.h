//
//  CameraViewController.h
//  ScrapBook
//
//  Created by Kevin Choi on 10/16/13.
//  Copyright (c) 2013 Kevin Choi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CameraViewController : UIViewController <UIImagePickerControllerDelegate>

@property UIImagePickerController *camera;
@property UIImagePickerController *photoReel;

@property UIButton *presentCameraButton;
@property UIImageView *selectedImageView;

@property UITabBarController *tabBarController;
- (void)setUp;

@end
