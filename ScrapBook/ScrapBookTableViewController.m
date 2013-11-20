//
//  ScrapBookTableViewController.m
//  ScrapBook
//
//  Created by Kevin Choi on 10/1/13.
//  Copyright (c) 2013 Kevin Choi. All rights reserved.
//

#import "ScrapBookTableViewController.h"
#import "Database.h"

@interface ScrapBookTableViewController ()

@end

@implementation ScrapBookTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        self.tableView.rowHeight = 100;
        // Fetch the data from the database
        self.scrapbook = [Database fetchAllScraps];
        
        // Register the type of view to create for a table cell
        [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
        
        // initialize the scrap creation view controller
        self.addScrapViewController = [[AddScrapViewController alloc] initWithNibName:@"AddScrapViewController" bundle:nil];
        self.addScrapViewController.target = self;
        self.addScrapViewController.action = @selector(addScrap:);
                
        // initialize the scrap detail view controller
        self.detailScrapViewController = [[DetailScrapViewController alloc] initWithNibName:@"DetailScrapViewController" bundle:nil];
        self.detailScrapViewController.target = self;
        self.detailScrapViewController.action = @selector(editScrap:);

    }
    return self;
}

- (void)addScrap:(NSMutableDictionary *)data
{
    // we have to tell the tableView to reload itself after we modify the data array
    [Database saveScrap:[data objectForKey:@"name"] andDetails:[data objectForKey:@"details"] andPhoto:[data objectForKey:@"picture"]];
     self.scrapbook = [Database fetchAllScraps];
    [self.tableView reloadData];
}

- (void)editScrap:(NSMutableDictionary *)data
{
    // we have to tell the tableView to reload itself after we modify the data array
    [Database updateScrap:[data objectForKey:@"name"] andDetails:[data objectForKey:@"details"] andPhoto:[data objectForKey:@"picture"] andRow:[[data objectForKey:@"rid"] intValue]];
    self.scrapbook = [Database fetchAllScraps];
    [self.tableView reloadData];
}


- (void)addNewScrapButtonPressed
{
    [self.navigationController pushViewController:self.addScrapViewController animated:YES];
    [self.addScrapViewController clearFields];
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
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.scrapbook count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    for (UIView *subview in [cell.contentView subviews]) {
        [subview removeFromSuperview];
    }

    // Configure the cell...
    Scrap *temp = [self.scrapbook objectAtIndex:indexPath.row];
    temp.picture.frame = CGRectMake(0, 0, 100, 100);
    temp.picture.contentMode = UIViewContentModeScaleAspectFit;
    [cell.contentView addSubview:temp.picture];
    UILabel *tempLabel = [[UILabel alloc] initWithFrame:CGRectMake(120, 0, 170, 100)];
    tempLabel.text = temp.name;
    [cell.contentView addSubview:tempLabel];
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


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [Database deleteScrap:[[self.scrapbook objectAtIndex:indexPath.row] rid]];
        self.scrapbook = [Database fetchAllScraps];

        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}


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
    Scrap *temp = [self.scrapbook objectAtIndex:indexPath.row];
    
    /* Interesting lesson here.
     * Technically, we've initialized the contactDetailViewController, right?
     * So you'd THINK the textFields in the nib file would already be loaded, but iOS is lazy
     * So the view is only loaded from the nib at the moment it's placed on the screen.
     * This means that if we reversed these next two lines, the very first time we tap on a contact
     * the contact detail view won't show us the data, but all subsequent contact taps WILL show us the data
     * to see what I mean, try reversing these lines and running the app
     */
    
    [self.navigationController pushViewController:self.detailScrapViewController animated:YES];
    [self.detailScrapViewController setFieldsWithName:temp.name withDetails:temp.details withPicture:temp.picture withRow:indexPath.row];
}

@end
