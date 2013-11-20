//
//  DetailScrapViewController.m
//  ScrapBook
//
//  Created by Kevin Choi on 10/2/13.
//  Copyright (c) 2013 Kevin Choi. All rights reserved.
//

#import "DetailScrapViewController.h"

@interface DetailScrapViewController ()

@end

@implementation DetailScrapViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // add edit button
        [self.navigationItem setTitle:@"Scrap"];
        [self.navigationItem setRightBarButtonItems:[NSArray arrayWithObject:[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(editScrapButtonPressed)]] animated:NO];
        self.editScrapViewController = [[EditScrapViewController alloc] initWithNibName:@"EditScrapViewController" bundle:nil];
        [self.editScrapViewController.navigationItem setTitle:@"Edit Scrap"];
        self.editScrapViewController.target = self;
        self.editScrapViewController.action = @selector(saveScrap:);
    }
    return self;
}

- (void)saveScrap:(NSMutableData *)data
{
    [self.target performSelector:self.action withObject:data];
}

- (void)editScrapButtonPressed
{
    [self.editScrapViewController setFieldsWithName:self.name.text withDetails:self.details.text withPicture:self.picture withRow:self.rid];
    [self.navigationController pushViewController:self.editScrapViewController animated:YES];
}

- (void)setFieldsWithName:(NSString *)name withDetails:(NSString *)details withPicture:(UIImageView *)picture withRow:(int)rid
{
    [self.view setNeedsDisplay];
    self.rid = rid;
    [self.name setText:name];
    [self.details setText:details];
    [self.picture setImage:picture.image];
}

- (IBAction)tweetButtonPressed:(id)sender
{
    if([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter])
    {
        self.composer = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
        
        [self.composer setInitialText:@"Tweet text here!"];
        [self.composer addImage:self.picture.image];
        
        [self presentViewController:self.composer animated:YES completion:nil];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
