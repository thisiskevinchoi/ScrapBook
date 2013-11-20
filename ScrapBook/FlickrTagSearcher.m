//
//  FlickrTagSearcher.m
//  PictureSearch
//
//  Created by Kevin Choi on 9/25/13.
//  Copyright (c) 2013 Kevin Choi. All rights reserved.
//

#import "FlickrTagSearcher.h"

@implementation FlickrTagSearcher

- (id) initWithTagQuery:(NSString *)query andTarget:(id)target andAction:(SEL)action{
    self = [super init];
    if (self) {
        self.connection = [[NSURLConnection alloc] initWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=f76659effc5dad04e7a939d2a8375258&tags=%@&format=json&nojsoncallback=1", query]]] delegate:self];
        self.target = target;
        self.action = action;
    }
    return self;
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    self.data = [[NSMutableData alloc] initWithCapacity:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [self.data appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSMutableDictionary* dictionary = [NSJSONSerialization JSONObjectWithData:self.data options:NSJSONReadingMutableContainers error:nil];
    [self.target performSelector:self.action withObject:dictionary];
}


@end
