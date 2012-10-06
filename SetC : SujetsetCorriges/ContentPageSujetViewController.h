//
//  ContentPageSujetViewController.h
//  SetC : SujetsetCorriges
//
//  Created by Mestiri Hedi on 29/09/12.
//  Copyright (c) 2012 Mestiri Hedi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XMLParser.h"

@interface ContentPageSujetViewController : UIViewController <UITableViewDelegate,UITableViewDataSource>
{
    UILabel *introLabel;
    
    NSMutableDictionary *tabSujCorRangeParAnnee;
}

@property (strong, nonatomic) UIView *introView;
@property (strong, nonatomic) UITableView *tableSuj;
@property (strong, nonatomic) NSMutableArray *listeSujCor;
@property (strong, nonatomic) NSString *intro;


@end
