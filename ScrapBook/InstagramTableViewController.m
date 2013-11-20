//
//  InstagramTableViewController.m
//  ScrapBook
//
//  Created by Kevin Choi on 10/2/13.
//  Copyright (c) 2013 Kevin Choi. All rights reserved.
//

#import "InstagramTableViewController.h"

@interface InstagramTableViewController ()

@end

@implementation InstagramTableViewController

- (id)initWithQuery:(NSString *)query
{
    self = [super init];
    if (self) {
        // Custom initialization
        self.pictures = [[NSMutableArray alloc] initWithCapacity:0];
        
        //if no cells are already available
        [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
        self.tableView.rowHeight = 320;
        
        self.searcher = [[InstagramTagSearcher alloc] initWithTagQuery:query andTarget:self andAction:@selector(handleInstagramData:)];
    }
    return self;
}

- (void) handleInstagramData:(NSMutableDictionary *)data
{
    NSMutableArray *photos = [data objectForKey:@"data"];
    
    for (NSMutableDictionary *photo in photos) {
        ImageView* temp = [[ImageView alloc] initWithURL:[NSURL URLWithString:[[[photo objectForKey:@"images"] objectForKey:@"low_resolution"] objectForKey:@"url"]]];
        //[temp setFrame:CGRectMake(0,0,100,100)];
        [self.pictures addObject:temp];
    }
    [self.tableView reloadData];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return [self.pictures count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    for (UIView *subview in [cell.contentView subviews]) {
        [subview removeFromSuperview];
    }
    
    // Configure the cell...
    ImageView *pic = [self.pictures objectAtIndex:indexPath.row];
    [pic setFrame:CGRectMake(0, 0, 320, 320)];
    [cell.contentView addSubview: pic];
    [cell.contentView setNeedsDisplay];
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIImageView *temp = [self.pictures objectAtIndex:indexPath.row];
    
    /* Interesting lesson here.
     * Technically, we've initialized the contactDetailViewController, right?
     * So you'd THINK the textFields in the nib file would already be loaded, but iOS is lazy
     * So the view is only loaded from the nib at the moment it's placed on the screen.
     * This means that if we reversed these next two lines, the very first time we tap on a contact
     * the contact detail view won't show us the data, but all subsequent contact taps WILL show us the data
     * to see what I mean, try reversing these lines and running the app
     */
    [self.target performSelector:self.action withObject:temp];
    [self.navigationController popViewControllerAnimated:YES];
}

@end
