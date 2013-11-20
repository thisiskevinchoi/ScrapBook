//
//  Scrap.h
//  ScrapBook
//
//  Created by Kevin Choi on 10/1/13.
//  Copyright (c) 2013 Kevin Choi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Scrap : NSObject

@property NSString *name;
@property NSString *details;
@property NSString *url;
@property UIImageView *picture;
@property int rid;

- (id)initWithName:(NSString *)name withDetails:(NSString *)details withPicture:(UIImageView *)picture withRow:(int)rid;

@end
