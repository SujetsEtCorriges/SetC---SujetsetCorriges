//
//  PartageViewController.h
//  SetC : SujetsetCorriges
//
//  Created by Jérémy on 02/10/12.
//  Copyright (c) 2012 Mestiri Hedi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommentsViewController.h"

@interface PartageViewController : UIViewController <PPRevealSideViewControllerDelegate>
{
    UIButton *_boutonCom;
    UIButton *_boutonFacebook;
    UIButton *_boutonTwitter;
    UIButton *_boutonMail;
    UIButton *_boutonSafari;
}

@property (strong, nonatomic) NSString *urlComments;

@end
