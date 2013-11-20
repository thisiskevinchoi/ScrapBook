//
//  InstagramTagSearcher.m
//  PictureSearch
//
//  Created by Kevin Choi on 9/24/13.
//  Copyright (c) 2013 Kevin Choi. All rights reserved.
//

#import "InstagramTagSearcher.h"

@implementation InstagramTagSearcher

- (id) initWithTagQuery:(NSString *)query andTarget:(id)target andAction:(SEL)action{
    self = [super init];
    if (self) {
        self.connection = [[NSURLConnection alloc] initWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://api.instagram.com/v1/tags/%@/media/recent?client_id=52b557afb1c64d5aa7480bef6c368f3e", query]]] delegate:self];
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
