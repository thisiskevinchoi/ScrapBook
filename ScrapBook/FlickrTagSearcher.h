//
//  FlickrTagSearcher.h
//  PictureSearch
//
//  Created by Kevin Choi on 9/25/13.
//  Copyright (c) 2013 Kevin Choi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FlickrTagSearcher : NSObject

@property NSURLConnection* connection;
@property NSMutableData* data;

@property id target;
@property SEL action;

- (id) initWithTagQuery:(NSString *)query andTarget:(id)target andAction:(SEL)action;
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response;
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data;
- (void)connectionDidFinishLoading:(NSURLConnection *)connection;

@end
