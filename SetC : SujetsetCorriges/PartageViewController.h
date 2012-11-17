//
//  PartageViewController.h
//  SetC : SujetsetCorriges
//
//  Created by Jérémy on 02/10/12.
//  Copyright (c) 2012 Mestiri Hedi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommentsViewController.h"

#define SYSTEM_VERSION_LESS_THAN(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)

@interface PartageViewController : UIViewController <PPRevealSideViewControllerDelegate>
{
    UIButton *boutonCom_;
    UIButton *boutonFacebook_;
    UIButton *boutonTwitter_;
    UIButton *boutonMail_;
    UIButton *boutonSafari_;
}

@property (strong, nonatomic) NSString *urlComments;
@property (strong, nonatomic) NSString *idArticle;
@property (strong, nonatomic) NSString *titreArticle;

@end
