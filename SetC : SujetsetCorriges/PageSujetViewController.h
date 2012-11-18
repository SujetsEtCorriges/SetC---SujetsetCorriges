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
#import "XMLParser.h"
#import "MBProgressHUD.h"

//ASIHTTPRequest
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"

@interface PageSujetViewController : UIViewController <UIPageViewControllerDataSource, XMLParserDelegate, UIPickerViewAccessibilityDelegate, UIPickerViewDataSource, UIPickerViewDelegate, UIActionSheetDelegate>
{
    XMLParser *parser_;
    
    //variables pour le picker view
    NSArray *tabFiliere_; //tableau des filiere
    NSString *filiere_; //filiere actuelle
    UIActionSheet *menu_; //menu du picker
    NSInteger filiereRow_; //row de la filiere actuelle
}

@property (strong, nonatomic) UIPageViewController *pageController;
@property (strong, nonatomic) NSArray *pageContent;
@property (strong, nonatomic) NSString *concours;

@end
