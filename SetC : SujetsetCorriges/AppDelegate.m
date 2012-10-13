//
//  AppDelegate.m
//  SetC : SujetsetCorriges
//
//  Created by Mestiri Hedi on 22/08/12.
//  Copyright (c) 2012 Mestiri Hedi. All rights reserved.
//

#import "AppDelegate.h"

#import "FirstViewController.h"
#import "SecondViewController.h"

@implementation AppDelegate
@synthesize window = _window;
@synthesize revealSideViewController = _revealSideViewController;
@synthesize revealSideViewActuController = _revealSideViewActuController;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    
    UIViewController *viewController1, *viewController2;
    [[UINavigationBar appearance] setTintColor:[UIColor colorWithRed:42/255.0f green:50/255.0f blue:59/255.0f alpha:1.0]];
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
    {
        _actuViewController = [[ActuViewController alloc] initWithStyle:UITableViewStylePlain];
        _navActuController = [[UINavigationController alloc] initWithRootViewController:_actuViewController];
        _revealSideViewActuController = [[PPRevealSideViewController alloc] initWithRootViewController:_navActuController];
        _revealSideViewActuController.delegate = self;
               
        _pageSujetViewController = [[PageSujetViewController alloc] initWithNibName:@"PageSujetViewController" bundle:nil];
        _navSujetController = [[UINavigationController alloc] initWithRootViewController:_pageSujetViewController];
        self.revealSideViewController = [[PPRevealSideViewController alloc] initWithRootViewController:_navSujetController];
        [self.revealSideViewController setDirectionsToShowBounce:PPRevealSideDirectionNone];
        [self.revealSideViewController changeOffset:10 forDirection:PPRevealSideDirectionLeft animated:YES];
        
        _listeConcoursViewController = [[ListeConcoursViewController alloc] initWithNibName:@"ListeConcoursViewController" bundle:nil];
        _navSimuController = [[UINavigationController alloc] initWithRootViewController:_listeConcoursViewController];
        
        //initialisation de la tabBar et insertion des vues
        self.tabBarController = [[UITabBarController alloc] init];
        self.tabBarController.viewControllers = @[_revealSideViewActuController, self.revealSideViewController, _navSimuController];
        
    }
    else
    {
        viewController1 = [[FirstViewController alloc] initWithNibName:@"FirstViewController_iPad" bundle:nil];
        viewController2 = [[SecondViewController alloc] initWithNibName:@"SecondViewController_iPad" bundle:nil];
        
        //initialisation de la tabBar et insertion des vues
        self.tabBarController = [[UITabBarController alloc] init];
        self.tabBarController.viewControllers = @[viewController1, viewController2];
    }
    
    
    
    self.window.rootViewController = self.tabBarController;
    [self.window makeKeyAndVisible];
    
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

- (void)pprevealSideViewController:(PPRevealSideViewController *)controller willPopToController:(UIViewController *)centerController
{
    UINavigationController *centerNavController = (UINavigationController *) centerController;
    ActuDetailViewController *actuDVC = (ActuDetailViewController *) centerNavController.visibleViewController;
    
    CommentsViewController *comVC = [[CommentsViewController alloc] initWithNibName:@"CommentsViewController" bundle:nil];
    comVC.url = [NSString stringWithFormat:@"%@feed",actuDVC.url];
    
    [_navActuController pushViewController:comVC animated:YES];
    
}

/*
// Optional UITabBarControllerDelegate method.
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
}
*/

/*
// Optional UITabBarControllerDelegate method.
- (void)tabBarController:(UITabBarController *)tabBarController didEndCustomizingViewControllers:(NSArray *)viewControllers changed:(BOOL)changed
{
}
*/

@end
