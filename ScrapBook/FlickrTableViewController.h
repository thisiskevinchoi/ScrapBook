//
//  FlickrTableViewController.h
//  ScrapBook
//
//  Created by Kevin Choi on 10/2/13.
//  Copyright (c) 2013 Kevin Choi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FlickrTagSearcher.h"
#import "ImageView.h"

@interface FlickrTableViewController : UITableViewController

@property FlickrTagSearcher *searcher;
@property (strong, nonatomic) NSMutableArray *pictures;

@property id target;
@property SEL action;

- (id)initWithQuery:(NSString *)query;
@end
