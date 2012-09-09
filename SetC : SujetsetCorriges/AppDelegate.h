//
//  AppDelegate.h
//  SetC : SujetsetCorriges
//
//  Created by Mestiri Hedi on 22/08/12.
//  Copyright (c) 2012 Mestiri Hedi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ActuViewController.h"
#import "SujetViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate, UITabBarControllerDelegate>
{
    ActuViewController *_actuViewController;
    UINavigationController *_navActuController;
    
    SujetViewController *_sujetViewController;
    UINavigationController *_navSujetController;
    //PPRevealSideViewController *_revealSideViewController;
}

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) PPRevealSideViewController *revealSideViewController;
@property (strong, nonatomic) UITabBarController *tabBarController;

@end
