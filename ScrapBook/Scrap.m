//
//  Scrap.m
//  ScrapBook
//
//  Created by Kevin Choi on 10/1/13.
//  Copyright (c) 2013 Kevin Choi. All rights reserved.
//

#import "Scrap.h"

@implementation Scrap

- (id)initWithName:(NSString *)name withDetails:(NSString *)details withPicture:(UIImageView *)picture withRow:(int)rid
{
    self.name = name;
    self.details = details;
    self.picture = picture;
    self.rid = rid;
    return self;
}

@end
