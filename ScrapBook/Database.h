//
//  Database.h
//  ScrapBook
//
//  Created by Kevin Choi on 10/7/13.
//  Copyright (c) 2013 Kevin Choi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Scrap.h"
#import <sqlite3.h>

@interface Database : NSObject

+ (void)createEditableCopyOfDatabaseIfNeeded;
+ (void)initDatabase;
+ (NSMutableArray *)fetchAllScraps;
+ (void)saveScrap:(NSString *)name andDetails:(NSString *)details andPhoto:(UIImageView *)photo;
+ (void)deleteScrap:(int)rowid;
+ (void)cleanUpDatabaseForQuit;
+ (void)updateScrap:(NSString *)name andDetails:(NSString *)details andPhoto:(UIImageView *)photo andRow:(int)rid;

@end
