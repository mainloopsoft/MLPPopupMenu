//
//  MLAppDelegate.m
//  MLPopupMenu
//
//  Created by Javier Figueroa on 4/10/13.
//  Copyright (c) 2013 Mainloop LLC. All rights reserved.
//

#import "MLPAppDelegate.h"
#import "MLPViewController.h"

@implementation MLPAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    
    MLPViewController *viewController = [[MLPViewController alloc] init];
    self.window.rootViewController = viewController;
    
    [[UITabBar appearance] setBackgroundImage:[self blueBarBackground]];
    [[UINavigationBar appearance] setBackgroundImage:[self blueBarBackground] forBarMetrics:UIBarMetricsDefault];
    [[UIBarButtonItem appearance] setBackgroundImage:[self blueBarBackground] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
        
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

- (UIColor *)mainloopBlueColor
{
    return [UIColor colorWithRed:0.0542516 green:0.44115  blue:0.699654 alpha:1];
}

- (UIImage *)blueBarBackground
{
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    
    CGContextRef composedImageContext = CGBitmapContextCreate(NULL,
                                                              10,
                                                              10,
                                                              8,
                                                              10*4,
                                                              colorSpace,
                                                              kCGImageAlphaPremultipliedFirst);
    
    CGColorSpaceRelease(colorSpace);
    
    
    CGContextSetFillColorWithColor(composedImageContext, [self.mainloopBlueColor CGColor]);
    CGContextFillRect(composedImageContext, CGRectMake(0, 0, 10, 10));
    
    
    CGImageRef cgImage = CGBitmapContextCreateImage(composedImageContext);
    
    return [UIImage imageWithCGImage:cgImage];
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
