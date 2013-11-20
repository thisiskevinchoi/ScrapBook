//
//  ScrapBookTableViewController.h
//  ScrapBook
//
//  Created by Kevin Choi on 10/1/13.
//  Copyright (c) 2013 Kevin Choi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Scrap.h"
#import "AddScrapViewController.h"
#import "DetailScrapViewController.h"

@interface ScrapBookTableViewController : UITableViewController

@property NSMutableArray *scrapbook;
@property AddScrapViewController *addScrapViewController;
@property DetailScrapViewController *detailScrapViewController;

- (void)addScrap:(NSMutableDictionary *)data;
- (void)addNewScrapButtonPressed;
@end
