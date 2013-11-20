//
//  EditScrapViewController.h
//  ScrapBook
//
//  Created by Kevin Choi on 10/8/13.
//  Copyright (c) 2013 Kevin Choi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TabBarController.h"

@interface EditScrapViewController : UIViewController <UITextFieldDelegate>

@property IBOutlet UITextField *name;
@property IBOutlet UITextField *details;
@property IBOutlet UITextField *query;
@property IBOutlet UIButton *addPictureButton;
@property IBOutlet UIButton *saveScrapButton;
@property IBOutlet UIImageView *picture;
@property int rid;

@property id target;
@property SEL action;

@property TabBarController *tabBarController;

-(IBAction)addPictureButtonDidGetPressed;
-(IBAction)saveScrapButtonDidGetPressed:(id)sender;
- (void)setFieldsWithName:(NSString *)name withDetails:(NSString *)details withPicture:(UIImageView *)picture withRow:(int)rid;

@end