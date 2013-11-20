//
//  EditScrapViewController.m
//  ScrapBook
//
//  Created by Kevin Choi on 10/8/13.
//  Copyright (c) 2013 Kevin Choi. All rights reserved.
//

#import "EditScrapViewController.h"

@interface EditScrapViewController ()

@end

@implementation EditScrapViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil andData:(NSDictionary *)data
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.picture = [[UIImageView alloc] init];
    }
    return self;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    textField.placeholder = nil;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    NSString *value = [textField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    if(value.length == 0) {
        textField.text = @"";
    }
    textField.placeholder = @"Add Text";
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (self.name.isFirstResponder) {
        [self.name resignFirstResponder];
    }
    if (self.details.isFirstResponder) {
        [self.details resignFirstResponder];
    }
    if (self.query.isFirstResponder) {
        [self.query resignFirstResponder];
    }
    return YES;
}

- (IBAction)addPictureButtonDidGetPressed
{
    NSString *query = [self.query.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    if ([query isEqual:@""])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Incomplete field"
                                                        message:@"No text in the query field!"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles: nil];
        [alert show];
        return;
    }

    self.tabBarController = [[TabBarController alloc] initWithQuery:self.query.text];
    self.tabBarController.target = self;
    self.tabBarController.action = @selector(saveImage:);
    [self.navigationController pushViewController:self.tabBarController animated:YES];
}

- (void)setFieldsWithName:(NSString *)name withDetails:(NSString *)details withPicture:(UIImageView *)picture withRow:(int)rid
{
    [self.view setNeedsDisplay];
    self.rid = rid;
    [self.name setText:name];
    [self.details setText:details];
    [self.picture setImage:picture.image];
    [self.query setText:@""];
}

- (void)saveImage:(id)sender
{
    UIImageView* temp = sender;
    [self.picture setImage:temp.image];
}


- (IBAction)saveScrapButtonDidGetPressed:(id)sender
{
    NSString *name = [self.name.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *details = [self.details.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    if ([name isEqual:@""] && [details isEqual:@""])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Incomplete Fields"
                                                        message:@"No text in the Name and Details field!"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles: nil];
        [alert show];
        return;
    }
    if ([name isEqual:@""])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Incomplete Field"
                                                        message:@"No text in the Name field!"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles: nil];
        [alert show];
        return;
    }
    if ([details isEqual:@""])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Incomplete Field"
                                                        message:@"No text in the Details field!"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles: nil];
        [alert show];
        return;
    }
    
    if (CGSizeEqualToSize(self.picture.image.size, CGSizeZero))
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"No Picture Data"
                                                        message:@"Missing picture data!"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles: nil];
        [alert show];
        return;
    }
    
    NSMutableDictionary *temp = [NSMutableDictionary dictionaryWithObjects:[NSArray arrayWithObjects:self.name.text, self.details.text, self.picture, [NSNumber numberWithInt:self.rid], nil] forKeys:[NSArray arrayWithObjects:@"name", @"details", @"picture", @"rid", nil]];
    [self.target performSelector:self.action withObject:temp];
    [self.navigationController popToRootViewControllerAnimated:YES];
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