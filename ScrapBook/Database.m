//
//  Database.m
//  ScrapBook
//
//  Created by Kevin Choi on 10/7/13.
//  Copyright (c) 2013 Kevin Choi. All rights reserved.
//

#import "Database.h"

@implementation Database

static sqlite3 *db;

static sqlite3_stmt *createScrap;
static sqlite3_stmt *fetchScrapBook;
static sqlite3_stmt *insertScrap;
static sqlite3_stmt *deleteScrap;
static sqlite3_stmt *updateScrap;

+ (void)createEditableCopyOfDatabaseIfNeeded
{
    BOOL success;
    
    // look for an existing contacts database
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [paths objectAtIndex:0];
    NSString *writableDBPath = [documentDirectory stringByAppendingPathComponent:@"scrapbook.sql"];
    success = [fileManager fileExistsAtPath:writableDBPath];
    if (success) return;
    
    // if failed to find one, copy the empty contacts database into the location
    NSString *defaultDBPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"scrapbook.sql"];
    success = [fileManager copyItemAtPath:defaultDBPath toPath:writableDBPath error:&error];
    if (!success) {
        NSAssert1(0, @"FAILED to create writable database file with message, '%@'.", [error localizedDescription]);
    }

}
+ (void)initDatabase
{
    
    // create the statement strings
    const char *createScrapString = "CREATE TABLE IF NOT EXISTS scrapbook (rowid INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, details TEXT, photo BLOB)";
    const char *fetchScrapString = "SELECT * FROM scrapbook";
    const char *insertScrapString = "INSERT INTO scrapbook (name, details, photo) VALUES (?, ?, ?)";
    const char *deleteScrapString = "DELETE FROM scrapbook WHERE rowid=?";
    const char *updateScrapString = "UPDATE scrapbook SET name = ?, details = ?, photo = ? WHERE rowid = ?";
    
    // create the path to the database
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [paths objectAtIndex:0];
    NSString *path = [documentDirectory stringByAppendingPathComponent:@"scrapbook.sql"];
    
    // open the database connection
    if (sqlite3_open([path UTF8String], &db)) {
        NSLog(@"ERROR opening the db");
    }
    
    
    
    int success;
    
    //init table statement
    if (sqlite3_prepare_v2(db, createScrapString, -1, &createScrap, NULL) != SQLITE_OK) {
        NSLog(@"Failed to prepare scrap create table statement");
    }
    
    // execute the table creation statement
    success = sqlite3_step(createScrap);
    sqlite3_reset(createScrap);
    if (success != SQLITE_DONE) {
        NSLog(@"ERROR: failed to create scrap table");
    }
    
    //init retrieval statement
    if (sqlite3_prepare_v2(db, fetchScrapString, -1, &fetchScrapBook, NULL) != SQLITE_OK) {
        NSLog(@"ERROR: failed to prepare scrap fetching statement");
    }
    
    //init insertion statement
    if (sqlite3_prepare_v2(db, insertScrapString, -1, &insertScrap, NULL) != SQLITE_OK) {
        NSLog(@"ERROR: failed to prepare scrap inserting statement");
    }
    
    // init deletion statement
    if (sqlite3_prepare_v2(db, deleteScrapString, -1, &deleteScrap, NULL) != SQLITE_OK) {
        NSLog(@"ERROR: failed to prepare scrap deleting statement");
    }
    
    // init update statement
    if (sqlite3_prepare_v2(db, updateScrapString, -1, &updateScrap, NULL) != SQLITE_OK) {
        NSLog(@"ERROR: failed to prepare scrap updating statement");
    }

}
+ (NSMutableArray *)fetchAllScraps
{
    NSMutableArray *ret = [NSMutableArray arrayWithCapacity:0];
    
    while (sqlite3_step(fetchScrapBook) == SQLITE_ROW) {
        
        // query columns from fetch statement
        char *name = (char *) sqlite3_column_text(fetchScrapBook, 1);
        char *details = (char *) sqlite3_column_text(fetchScrapBook, 2);
        
        NSData *picture = [[NSData alloc] initWithBytes:sqlite3_column_blob(fetchScrapBook, 3) length: sqlite3_column_bytes(fetchScrapBook, 3)];
        
        // convert to NSStrings
        NSString *tempname = [NSString stringWithUTF8String:name];
        NSString *tempdetails = [NSString stringWithUTF8String:details];
        UIImage *image= [[UIImage alloc] initWithData:picture];
        UIImageView *temppic = [[UIImageView alloc] initWithImage:image];
        //create Contact object, notice the query for the row id
        Scrap *temp = [[Scrap alloc] initWithName:tempname withDetails:tempdetails withPicture:temppic withRow:sqlite3_column_int(fetchScrapBook, 0)];
        [ret addObject:temp];
    }
    
    sqlite3_reset(fetchScrapBook);
    return ret;
}
+ (void)saveScrap:(NSString *)name andDetails:(NSString *)details andPhoto:(UIImageView *)photo
{
    // bind data to the statement
    sqlite3_bind_text(insertScrap, 1, [name UTF8String], -1, SQLITE_TRANSIENT);
    sqlite3_bind_text(insertScrap, 2, [details UTF8String], -1, SQLITE_TRANSIENT);
    
    NSData *imageData = UIImagePNGRepresentation(photo.image);
    sqlite3_bind_blob(insertScrap, 3, [imageData bytes], [imageData length], SQLITE_STATIC);
    
    int success = sqlite3_step(insertScrap);
    sqlite3_reset(insertScrap);
    if (success != SQLITE_DONE) {
        NSLog(@"ERROR: failed to insert scrap");
    }

}
+ (void)deleteScrap:(int)rowid
{
    // bind the row id, step the statement, reset the statement, check for error... EASY
    sqlite3_bind_int(deleteScrap, 1, rowid);
    int success = sqlite3_step(deleteScrap);
    sqlite3_reset(deleteScrap);
    if (success != SQLITE_DONE) {
        NSLog(@"ERROR: failed to delete scrap");
    }
    
}
+ (void)updateScrap:(NSString *)name andDetails:(NSString *)details andPhoto:(UIImageView *)photo andRow:(int)rid
{
    // bind data to the statement
    sqlite3_bind_text(updateScrap, 1, [name UTF8String], -1, SQLITE_TRANSIENT);
    sqlite3_bind_text(updateScrap, 2, [details UTF8String], -1, SQLITE_TRANSIENT);
    
    NSData *imageData = UIImagePNGRepresentation(photo.image);
    sqlite3_bind_blob(updateScrap, 3, [imageData bytes], [imageData length], SQLITE_STATIC);
    
    sqlite3_bind_int(updateScrap, 4, rid+1);
    
    int success = sqlite3_step(updateScrap);
    sqlite3_reset(updateScrap);
    if (success != SQLITE_DONE) {
        NSLog(@"ERROR: failed to update scrap");
    }
}
+ (void)cleanUpDatabaseForQuit
{
    // finalize frees the compiled statements, close closes the database connection
    sqlite3_finalize(fetchScrapBook);
    sqlite3_finalize(insertScrap);
    sqlite3_finalize(deleteScrap);
    sqlite3_finalize(createScrap);
    sqlite3_finalize(updateScrap);
    sqlite3_close(db);
}

@end
