//
//  ImageView.m
//  PictureSearch
//
//  Created by Kevin Choi on 9/24/13.
//  Copyright (c) 2013 Kevin Choi. All rights reserved.
//

#import "ImageView.h"

@implementation ImageView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)initWithURL:(NSURL *)url
{
    self = [super init];
    if (self) {
        self.connection = [[NSURLConnection alloc] initWithRequest:[NSURLRequest requestWithURL:url] delegate:self];
    }
    return self;
}

- (void)requestImage
{
    if (self.connection) {
        [self.connection start];
    }
}

- (void)requestImageWithURLFromString:(NSString *)url
{
    if (self.connection) {
        [self.connection cancel];
    }
    
    self.connection = [[NSURLConnection alloc] initWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]] delegate:self];
    
    if (self.connection) {
        [self.connection start];
    }
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    self.webData = [[NSMutableData alloc] initWithCapacity:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    if (self.webData == nil) {
        self.webData = [[NSMutableData alloc] initWithCapacity:0];
    }
    
    [self.webData appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    [self setImage:[UIImage imageWithData:self.webData]];
}

- (void)resizeImage
{
    self.frame = CGRectMake(0, 0, 320, 320);
    self.contentMode = UIViewContentModeScaleAspectFit;
    self.center = self.superview.center;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
