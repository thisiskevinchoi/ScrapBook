//
//  AppDelegate.m
//  ScrapBook
//
//  Created by Kevin Choi on 10/1/13.
//  Copyright (c) 2013 Kevin Choi. All rights reserved.
//

#import "AppDelegate.h"
#import "Database.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [Database createEditableCopyOfDatabaseIfNeeded];
    [Database initDatabase];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    // Create the ScrapBook table view
    ScrapBookTableViewController *mainView = [[ScrapBookTableViewController alloc] initWithStyle:UITableViewStylePlain];
    
    // Customize the button text
    [[UIButton appearance] setTitleColor:[UIColor colorWithRed:255.0/255.0 green:120.0/255.0 blue:120.0/255.0 alpha:.5] forState:UIControlStateNormal];

    // Customize the nav bar:
    // Set the nav bar title
    [mainView.navigationItem setTitle:@"ScrapBook"];
    // Set the nav bar add button
    [mainView.navigationItem setRightBarButtonItems:[NSArray arrayWithObject:[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:mainView action:@selector(addNewScrapButtonPressed)]] animated:NO];
    // Set the nav bar colors
    [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:255.0/255.0 green:120.0/255.0 blue:120.0/255.0 alpha:.5]];
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    [[UINavigationBar appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                          [UIColor whiteColor], NSForegroundColorAttributeName,
                                                          nil]];
    // Set nav bar as the root view controller
    self.navController = [[UINavigationController alloc] initWithRootViewController:mainView];
    [self.navController.navigationBar setTranslucent:NO];

    // Customize the tab bar:
    // Set the tab bar colors
    [[UITabBar appearance] setBarTintColor:[UIColor colorWithRed:255.0/255.0 green:120.0/255.0 blue:120.0/255.0 alpha:.5]];
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                      [UIColor whiteColor], NSForegroundColorAttributeName
                                                       , nil] forState:UIControlStateSelected];
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                       [UIColor grayColor], NSForegroundColorAttributeName
                                                       , nil] forState:UIControlStateNormal];
    // Set application root view controller
    [self.window setRootViewController:self.navController];

    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
