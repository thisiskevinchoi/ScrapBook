//
//  CropperViewController.m
//  ScrapBook
//
//  Created by Kevin Choi on 10/28/13.
//  Copyright (c) 2013 Kevin Choi. All rights reserved.
//

#import "CropperViewController.h"

@interface CropperViewController ()

@end

@implementation CropperViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        [self.view setBackgroundColor:[UIColor whiteColor]];
        
        // setup the main image view and the image view for the cropped image
        self.mainImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 320)];
        [self.mainImageView setContentMode:UIViewContentModeScaleAspectFit];
        self.croppedImageView = [[UIImageView alloc] initWithFrame:CGRectMake(110, 320, 100, 100)];
        self.origImage =[[UIImage alloc] init];
        
        // we want touches to be passed to child views of this image view
        [self.mainImageView setUserInteractionEnabled:YES];
        
        // create the red cropper box
        self.cropper = [[CropRegionView alloc] initWithFrame:CGRectMake(110, 110, 100, 100)];
        self.cropper.parentView = self.mainImageView;
        [self.mainImageView addSubview:self.cropper];
        
        // setup the tap gesture recognizer for the cropper
        self.doubleTabRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cropImageAndSendToTarget)];
        [self.doubleTabRecognizer setNumberOfTapsRequired:2];
        [self.cropper addGestureRecognizer:self.doubleTabRecognizer];
        
        // saveButton
        self.saveButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [self.saveButton setFrame:CGRectMake(210, 320, 110, 50)];
        [self.saveButton setTitle:@"Save" forState:UIControlStateNormal];
        [self.saveButton addTarget:self action:@selector(saveButtonPressed) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:self.saveButton];
        
        // origButton
        self.origButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [self.origButton setFrame:CGRectMake(0, 323, 110, 23)];
        [self.origButton setTitle:@"Original Image" forState:UIControlStateNormal];
        [self.origButton addTarget:self action:@selector(applyOrig) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:self.origButton];
        
        // sepiaButton
        self.sepiaButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [self.sepiaButton setFrame:CGRectMake(0, 346, 110, 23)];
        [self.sepiaButton setTitle:@"Sepia" forState:UIControlStateNormal];
        [self.sepiaButton addTarget:self action:@selector(applySepia) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:self.sepiaButton];
        
        // negativeButton
        self.negativeButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [self.negativeButton setFrame:CGRectMake(0, 369, 110, 23)];
        [self.negativeButton setTitle:@"Negative" forState:UIControlStateNormal];
        [self.negativeButton addTarget:self action:@selector(applyNegative) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:self.negativeButton];
        
        // posterizeButton
        self.posterizeButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [self.posterizeButton setFrame:CGRectMake(0, 392, 110, 23)];
        [self.posterizeButton setTitle:@"Sepia" forState:UIControlStateNormal];
        [self.posterizeButton addTarget:self action:@selector(applyPosterize) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:self.posterizeButton];
        
        // add the subviews to the view
        [self.view addSubview:self.mainImageView];
        [self.view addSubview:self.croppedImageView];
    }
    return self;
}

- (void)saveButtonPressed
{
    if (self.croppedImageView.image == nil)
    {
        [self.target performSelector:self.action withObject:self.mainImageView.image];
    }
    else
    {
        [self.target performSelector:self.action withObject:self.croppedImageView.image];
    }
}

- (void)applySepia
{
    if (self.mainImageView.image != nil) {
        
        CIContext *context = [CIContext contextWithOptions:nil];
        
        CIImage *original = [CIImage imageWithCGImage:self.mainImageView.image.CGImage];
        CIFilter *filter = [CIFilter filterWithName:@"CIPhotoEffectFade"];
        [filter setValue:original forKey:@"inputImage"];
        CIImage *newImage = [filter valueForKey:@"outputImage"];
        
        
        CIFilter *sepia = [CIFilter filterWithName:@"CISepiaTone"];
        [sepia setValue:newImage forKey:@"inputImage"];
        CIImage *newNewImage = [sepia valueForKey:@"outputImage"];
        
        CGImageRef cgimage = [context createCGImage:newNewImage fromRect:[newNewImage extent]];
        
        UIImage *newUIImage = [UIImage imageWithCGImage:cgimage];
        
        CGImageRelease(cgimage);
        
        
        // uncomment this line if you want to skip from CI to UI image... avoiding CG
        // this will allow you to avoid the need for creating a context and releasing a created CGImage
        //UIImage *newUIImage = [UIImage imageWithCIImage:newNewImage];
        
        [self.mainImageView setImage:newUIImage];
        [self cropImageAndSendToTarget];
    }
}

- (void)applyNegative
{
    if (self.mainImageView.image != nil) {
        
        CIContext *context = [CIContext contextWithOptions:nil];
        
        CIImage *original = [CIImage imageWithCGImage:self.mainImageView.image.CGImage];
        CIFilter *filter = [CIFilter filterWithName:@"CIPhotoEffectFade"];
        [filter setValue:original forKey:@"inputImage"];
        CIImage *newImage = [filter valueForKey:@"outputImage"];
        
        
        CIFilter *sepia = [CIFilter filterWithName:@"CIColorInvert"];
        [sepia setValue:newImage forKey:@"inputImage"];
        CIImage *newNewImage = [sepia valueForKey:@"outputImage"];
        
        CGImageRef cgimage = [context createCGImage:newNewImage fromRect:[newNewImage extent]];
        
        UIImage *newUIImage = [UIImage imageWithCGImage:cgimage];
        
        CGImageRelease(cgimage);
        
        
        // uncomment this line if you want to skip from CI to UI image... avoiding CG
        // this will allow you to avoid the need for creating a context and releasing a created CGImage
        //UIImage *newUIImage = [UIImage imageWithCIImage:newNewImage];
        
        [self.mainImageView setImage:newUIImage];
        [self cropImageAndSendToTarget];
    }
}

- (void)applyPosterize
{
    if (self.mainImageView.image != nil) {
        
        CIContext *context = [CIContext contextWithOptions:nil];
        
        CIImage *original = [CIImage imageWithCGImage:self.mainImageView.image.CGImage];
        CIFilter *filter = [CIFilter filterWithName:@"CIPhotoEffectFade"];
        [filter setValue:original forKey:@"inputImage"];
        CIImage *newImage = [filter valueForKey:@"outputImage"];
        
        
        CIFilter *sepia = [CIFilter filterWithName:@"CIColorPosterize"];
        [sepia setValue:newImage forKey:@"inputImage"];
        CIImage *newNewImage = [sepia valueForKey:@"outputImage"];
        
        CGImageRef cgimage = [context createCGImage:newNewImage fromRect:[newNewImage extent]];
        
        UIImage *newUIImage = [UIImage imageWithCGImage:cgimage];
        
        CGImageRelease(cgimage);
        
        
        // uncomment this line if you want to skip from CI to UI image... avoiding CG
        // this will allow you to avoid the need for creating a context and releasing a created CGImage
        //UIImage *newUIImage = [UIImage imageWithCIImage:newNewImage];
        
        [self.mainImageView setImage:newUIImage];
        [self cropImageAndSendToTarget];
    }
}

- (void)applyOrig
{
    if (self.mainImageView.image != nil) {
        [self.mainImageView setImage:self.origImage];
        [self cropImageAndSendToTarget];
    }
}

// set the image of the main image view
- (void)setImage:(UIImage *)newImage
{
    // set the image of course
    self.origImage = newImage;
    [self.croppedImageView setImage:nil];
    [self.mainImageView setImage:newImage];
    
    /*
     * here we precompute the bounds of the scaled image
     * within the main image view and pass those bounds
     * to the cropper
     */
    CGFloat inViewImageHeight;
    CGFloat inViewImageWidth;
    
    if (newImage.size.height > newImage.size.width) {
        inViewImageHeight = self.mainImageView.frame.size.height;
        inViewImageWidth = (inViewImageHeight/newImage.size.height) * newImage.size.width;
    } else {
        inViewImageWidth = self.mainImageView.frame.size.width;
        inViewImageHeight = (inViewImageWidth/newImage.size.width) * newImage.size.height;
    }
    
    CGFloat minX = (self.mainImageView.frame.size.width - inViewImageWidth)/2;
    CGFloat minY = (self.mainImageView.frame.size.height - inViewImageHeight)/2;
    
    // let the cropper know about the new bounds
    self.cropper.imageBoundsInView = CGRectMake(minX, minY, inViewImageWidth, inViewImageHeight);
    
    // ask the cropper to move itself based on these new bounds if necessary
    [self.cropper checkBounds];
}
// crop the image and based off the cropper's bounds and send it to the cropped image view
- (void)cropImageAndSendToTarget
{
    // get the original pixels from the image as a CGImage
    CGImageRef croppedCGImage = CGImageCreateWithImageInRect(self.mainImageView.image.CGImage, [self.cropper cropBounds]);
    
    // convert CGImage into UIImage
    UIImage *temp = [UIImage imageWithCGImage:croppedCGImage];
    
    // begin a magical 'graphics context' (think of this as an arbitrary place to draw things that is NOT a screen)
    UIGraphicsBeginImageContext(CGSizeMake(300.0, 300.0));
    
    // draw the UIImage to the new dimensions (this just magically draws it in the magical context we just opened)
    [temp drawInRect:CGRectMake(0, 0, 300, 300)];
    
    // fetch the freshly drawn image with it's new dimensions
    UIImage *croppedUIImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // end the graphics context
    UIGraphicsEndImageContext();
    
    // release the CGImage we created
    CGImageRelease(croppedCGImage);
    
    // send the new cropped UIImage to the cropped ImageView
    [self.croppedImageView setImage:croppedUIImage];
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
