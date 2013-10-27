//
//  AMAppDelegate.m
//  SlideoutStoryboardSample
//
//  Created by Andrea on 15/02/13.
//  Copyright (c) 2013 Andrea Mazzini. All rights reserved.
//

#import "TDAppDelegate.h"
#import "AMSlideOutNavigationController.h"


@implementation TDAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{

	UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
	UIViewController* controller;
	
	self.slideoutController = [AMSlideOutNavigationController slideOutNavigation];
    
    
	if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")) {
		//[self.slideoutController setSlideoutOptions:[AMSlideOutGlobals defaultFlatOptions]];
	}
	[self.slideoutController addSectionWithTitle:@"Section One"];
	
	NSString* icon1 = @"icon1.png";
	if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")) {
		icon1 = @"icon1b.png";
	}
	NSString* icon2 = @"icon2.png";
	if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")) {
		icon2 = @"icon2b.png";
	}
	
	controller = [storyboard instantiateViewControllerWithIdentifier:@"FirstController"];
	[self.slideoutController addViewControllerToLastSection:controller tagged:1 withTitle:@"Home" andIcon:@""];
	[self.slideoutController setBadgeValue:@"" forTag:1];
	controller = [storyboard instantiateViewControllerWithIdentifier:@"SecondController"];
	[self.slideoutController addViewControllerToLastSection:controller tagged:2 withTitle:@"Photos" andIcon:@""];
    
    controller = [storyboard instantiateViewControllerWithIdentifier:@"ThirdController"];
	[self.slideoutController addViewControllerToLastSection:controller tagged:3 withTitle:@"WebView" andIcon:@""];

    [self.slideoutController addSectionWithTitle:@"Section Two"];
    controller = [storyboard instantiateViewControllerWithIdentifier:@"FourthController"];
	[self.slideoutController addViewControllerToLastSection:controller tagged:4 withTitle:@"MapView" andIcon:@""];
    

    //[self.window setRootViewController:self.slideoutController];
    self.AmController= self.slideoutController;
    
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
