//
//  TabBarController.m
//  ScrapBook
//
//  Created by Kevin Choi on 10/2/13.
//  Copyright (c) 2013 Kevin Choi. All rights reserved.
//

#import "TabBarController.h"

@interface TabBarController ()

@end

@implementation TabBarController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithQuery:(NSString *)query
{
    self = [super init];
    if (self) {
        // Custom initialization
        [self.navigationItem setTitle:@"Add Picture"];
        // Create the InstagramViewController
        
        self.instagramSearcher = [[InstagramTableViewController alloc] initWithQuery:query];
        [self.instagramSearcher.view setBackgroundColor:[UIColor whiteColor]];
        [self.instagramSearcher.view setFrame:[[UIScreen mainScreen] bounds]];
        self.instagramSearcher.target = self;
        self.instagramSearcher.action = @selector(imagePressed:);
        // Instagram Tab
        self.instagramSearcher.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Instagram" image:nil tag:1];
        
        // Create the FlickrViewController
        self.flickrSearcher = [[FlickrTableViewController alloc] initWithQuery:query];
        [self.flickrSearcher.view setBackgroundColor:[UIColor whiteColor]];
        [self.flickrSearcher.view setFrame:[[UIScreen mainScreen] bounds]];
        self.flickrSearcher.target = self;
        self.flickrSearcher.action = @selector(imagePressed:);
        
        // Flickr Tab
        self.flickrSearcher.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Flickr" image:nil tag:2];
        
        // Add the viewcontrollers to the tab bar
        [self setViewControllers:[NSArray arrayWithObjects:self.instagramSearcher, self.flickrSearcher, nil] animated:YES];
        
        [self.tabBar setTranslucent:NO];
    }
    return self;
}

- (void)imagePressed:(id)sender
{
    UIImageView* temp = sender;
    [self.target performSelector:self.action withObject:temp];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
