//
//  AddScrapViewController.m
//  ScrapBook
//
//  Created by Kevin Choi on 10/1/13.
//  Copyright (c) 2013 Kevin Choi. All rights reserved.
//

#import "AddScrapViewController.h"

@interface AddScrapViewController ()

@end

@implementation AddScrapViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [self.navigationItem setTitle:@"Add Scrap"];
        self.picture = [[UIImageView alloc] init];
        
        self.cropViewController = [[CropperViewController alloc] init];
        
        self.camera = [[UIImagePickerController alloc] init];
        [self.camera setDelegate:self];
        [self.camera.tabBarItem setTitle:@"Camera"];
        
        UIButton *takePhoto = [UIButton buttonWithType:UIButtonTypeSystem];
        [takePhoto addTarget:self.camera action:@selector(takePicture) forControlEvents:UIControlEventTouchUpInside];
        [takePhoto setTitle:@"Take photo" forState:UIControlStateNormal];
        [takePhoto setBackgroundColor:[UIColor whiteColor]];
        
        // ADD CANCEL BUTTON
        
        // If there is a camera, use it
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            [self.camera setSourceType:UIImagePickerControllerSourceTypeCamera];
            [self.camera setCameraDevice:UIImagePickerControllerCameraDeviceRear];
            [self.camera setShowsCameraControls:NO];
            [self.camera setCameraOverlayView:takePhoto];
        }
        
        self.photoReel = [[UIImagePickerController alloc] init];
        [self.photoReel setDelegate:self];
        [self.photoReel.tabBarItem setTitle:@"Photo Reel"];
        
        // Camera
        self.photoTabBarController = [[UITabBarController alloc] init];
        [self.photoTabBarController setViewControllers:[NSArray arrayWithObjects:self.camera, self.photoReel, nil]];
        [takePhoto setFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height - self.photoTabBarController.tabBar.frame.size.height - 90, 320, 90)];
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

-(void)clearFields
{
    [self.name setText:@""];
    [self.details setText:@""];
    [self.query setText:@""];
    [self.picture setImage:nil];
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

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [self.photoTabBarController dismissViewControllerAnimated:YES completion:nil];
    
    //    for (NSString *str in [info keyEnumerator]) {
    //        NSLog(str);
    //    }
    
    self.picture.image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    // Necessary? Duplicate
    [self.picture setContentMode:UIViewContentModeScaleAspectFit];
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self.photoTabBarController dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)takePhotoButtonDidGetPressed
{
    [self presentViewController:self.photoTabBarController animated:YES completion:nil];
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

- (IBAction)editPictureButtonDidGetPressed
{
    if (self.picture.image == nil)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"No image"
                                                        message:@"No image chosen!"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles: nil];
        [alert show];
        return;
    }
    
    self.cropViewController.target = self;
    self.cropViewController.action = @selector(saveCroppedImage:);
    [self.navigationController pushViewController:self.cropViewController animated:YES];
    [self.cropViewController setImage:self.picture.image];
}

- (void)saveCroppedImage:(id)sender
{
    UIImage* temp = sender;
    [self.picture setImage:temp];
    [self.navigationController popViewControllerAnimated:YES];
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
    NSMutableDictionary *temp = [NSMutableDictionary dictionaryWithObjects:[NSArray arrayWithObjects:self.name.text, self.details.text, self.picture, nil] forKeys:[NSArray arrayWithObjects:@"name", @"details", @"picture", nil]];
    [self.target performSelector:self.action withObject:temp];
    [self.navigationController popViewControllerAnimated:YES];
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
