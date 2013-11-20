//
//  AddScrapViewController.h
//  ScrapBook
//
//  Created by Kevin Choi on 10/1/13.
//  Copyright (c) 2013 Kevin Choi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Scrap.h"
#import "TabBarController.h"
#import "InstagramTableViewController.h"
#import "FlickrTableViewController.h"
#import "CropperViewController.h"

@interface AddScrapViewController : UIViewController <UITextFieldDelegate, UIImagePickerControllerDelegate>

@property TabBarController *tabBarController;
@property CropperViewController *cropViewController;

@property IBOutlet UITextField *name;
@property IBOutlet UITextField *details;
@property IBOutlet UITextField *query;
@property IBOutlet UIButton *addPictureButton;
@property IBOutlet UIButton *saveScrapButton;
@property IBOutlet UIImageView *picture;

@property UIImagePickerController *camera;
@property UIImagePickerController *photoReel;
@property UITabBarController *photoTabBarController;

@property id target;
@property SEL action;

-(IBAction)takePhotoButtonDidGetPressed;
-(IBAction)addPictureButtonDidGetPressed;
-(IBAction)editPictureButtonDidGetPressed;
-(IBAction)saveScrapButtonDidGetPressed:(id)sender;
-(void)clearFields;

@end
