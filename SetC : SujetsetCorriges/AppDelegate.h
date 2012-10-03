//
//  AppDelegate.h
//  SetC : SujetsetCorriges
//
//  Created by Mestiri Hedi on 22/08/12.
//  Copyright (c) 2012 Mestiri Hedi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ActuViewController.h"
#import "PageSujetViewController.h"
#import "CommentsViewController.h"
#import "ActuDetailViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate, UITabBarControllerDelegate, PPRevealSideViewControllerDelegate>
{
    ActuViewController *_actuViewController;
    UINavigationController *_navActuController;
    
    PageSujetViewController *_pageSujetViewController;
    UINavigationController *_navSujetController;
    
    
}

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) PPRevealSideViewController *revealSideViewController;
@property (strong, nonatomic) PPRevealSideViewController *revealSideViewActuController;
@property (strong, nonatomic) UITabBarController *tabBarController;
@property (strong, nonatomic) NSString *concours;

@end
