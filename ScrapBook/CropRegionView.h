//
//  CropRegionView.h
//  ScrapBook
//
//  Created by Kevin Choi on 10/22/13.
//  Copyright (c) 2013 Kevin Choi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CropRegionView : UIView

// we want to know about the parentView
@property UIImageView *parentView;
// we also want to hold the bounds of the scaled image within the parent view
@property CGRect imageBoundsInView;

- (void)checkBounds;
- (CGRect)cropBounds;
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event;


@end
