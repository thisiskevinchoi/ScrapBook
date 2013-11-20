//
//  TabBarController.h
//  ScrapBook
//
//  Created by Kevin Choi on 10/2/13.
//  Copyright (c) 2013 Kevin Choi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InstagramTableViewController.h"
#import "FlickrTableViewController.h"

@interface TabBarController : UITabBarController

@property InstagramTableViewController* instagramSearcher;
@property FlickrTableViewController* flickrSearcher;

@property id target;
@property SEL action;

- (id)initWithQuery:(NSString *)query;
@end
