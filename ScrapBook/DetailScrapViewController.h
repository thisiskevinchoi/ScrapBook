//
//  DetailScrapViewController.h
//  ScrapBook
//
//  Created by Kevin Choi on 10/2/13.
//  Copyright (c) 2013 Kevin Choi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Social/Social.h>
#import "EditScrapViewController.h"

@interface DetailScrapViewController : UIViewController

@property IBOutlet UILabel *name;
@property IBOutlet UILabel *details;
@property IBOutlet UIImageView *picture;

@property EditScrapViewController *editScrapViewController;
@property int rid;

@property SLComposeViewController *composer;

@property id target;
@property SEL action;


- (void)setFieldsWithName:(NSString *)name withDetails:(NSString *)details withPicture:(UIImageView *)picture withRow:(int)rid;

@end
