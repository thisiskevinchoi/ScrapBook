//
//  CameraViewController.m
//  ScrapBook
//
//  Created by Kevin Choi on 10/16/13.
//  Copyright (c) 2013 Kevin Choi. All rights reserved.
//

#import "CameraViewController.h"

@interface CameraViewController ()

@end

@implementation CameraViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)setUp
{
    
    self.tabBarController = [[UITabBarController alloc] init];
    [self.tabBarController setViewControllers:[NSArray arrayWithObjects:self.camera, self.photoReel, nil]];
    
    self.camera = [[UIImagePickerController alloc] init];
    self.camera.delegate = self;
    [self.camera.tabBarItem setTitle:@"Camera"];
    
    UIButton *takePhoto = [UIButton buttonWithType:UIButtonTypeSystem];
    [takePhoto setFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height - self.tabBarController.tabBar.frame.size.height - 60, 320, 60)];
    [takePhoto addTarget:self.camera action:@selector(takePicture) forControlEvents:UIControlEventTouchUpInside];
    [takePhoto setTitle:@"Take PHOTO" forState:UIControlStateNormal];
    
    // ADD CANCEL BUTTON
    
    // If there is a camera, use it
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        [self.camera setSourceType:UIImagePickerControllerSourceTypeCamera];
        [self.camera setCameraDevice:UIImagePickerControllerCameraDeviceRear];
        [self.camera setShowsCameraControls:NO];
        [self.camera setCameraOverlayView:takePhoto];
    }
    
    self.presentCameraButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.presentCameraButton setFrame:CGRectMake(10, 360, 300, 40)];
    [self.presentCameraButton setTitle:@"Camera" forState:UIControlStateNormal];
    [self.presentCameraButton addTarget:self action:@selector(presentImagePickerView) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.presentCameraButton];
    
    self.selectedImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 20, 320, 320)];
    [self.selectedImageView setClipsToBounds:YES];
    [self.selectedImageView setContentMode:UIViewContentModeScaleAspectFit];
    
    [self.view addSubview:self.selectedImageView];
    
    self.photoReel = [[UIImagePickerController alloc] init];
    self.photoReel.delegate = self;
    [self.photoReel.tabBarItem setTitle:@"Photo Reel"];
    
    
}

- (void)presentImagePickerView
{
    [self presentViewController:self.tabBarController animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [self.tabBarController dismissViewControllerAnimated:YES completion:nil];
    
//    for (NSString *str in [info keyEnumerator]) {
//        NSLog(str);
//    }
    self.selectedImageView.image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    // Necessary? Duplicate
    [self.selectedImageView setContentMode:UIViewContentModeScaleAspectFit];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self.tabBarController dismissViewControllerAnimated:YES completion:nil];
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
