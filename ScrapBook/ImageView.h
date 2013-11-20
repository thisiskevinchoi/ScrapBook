//
//  ImageView.h
//  PictureSearch
//
//  Created by Kevin Choi on 9/24/13.
//  Copyright (c) 2013 Kevin Choi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageView : UIImageView <NSURLConnectionDataDelegate>

@property NSURLConnection *connection;
@property NSMutableData *webData;

- (id)initWithURL:(NSURL *)url;

- (void)requestImage;
- (void)requestImageWithURLFromString:(NSString *)url;

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response;
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data;
- (void)connectionDidFinishLoading:(NSURLConnection *)connection;

@end
