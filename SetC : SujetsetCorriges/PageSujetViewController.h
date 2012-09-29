//
//  PageSujetViewController.h
//  SetC : SujetsetCorriges
//
//  Created by Mestiri Hedi on 29/09/12.
//  Copyright (c) 2012 Mestiri Hedi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ContentPageSujetViewController.h"
#import "SectionListViewController.h"

@interface PageSujetViewController : UIViewController <UIPageViewControllerDataSource>
{
    UIPageViewController *pageController;
    NSArray *pageContent;
}

@property (strong, nonatomic) UIPageViewController *pageController;
@property (strong, nonatomic) NSArray *pageContent;

@end
