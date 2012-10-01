//
//  ActuDetailViewController.h
//  SetC : SujetsetCorriges
//
//  Created by Mestiri Hedi on 09/09/12.
//  Copyright (c) 2012 Mestiri Hedi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommentsViewController.h"
#import "SectionListViewController.h"

@interface ActuDetailViewController : UIViewController <UIWebViewDelegate>
{
    UILabel *texteLabel;
    UILabel *titreLabel;
    UILabel *dateLabel;
    UILabel *auteurLabel;
    
    UIScrollView *scrollView;
}

@property (strong, nonatomic) NSString *url;
@property (strong, nonatomic) NSString *texte;
@property (strong, nonatomic) NSString *titre;
@property (strong, nonatomic) NSString *date;
@property (strong, nonatomic) NSString *auteur;
@property (strong, nonatomic) UIWebView *webView;
@property (strong, nonatomic) UIView *infoView;

@end
