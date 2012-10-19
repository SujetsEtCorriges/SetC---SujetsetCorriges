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
    UILabel *_introLabel;
    
    NSMutableDictionary *_tabSujCorRangeParAnnee;
    NSArray *_tabAnneeOrdre;
}

@property (strong, nonatomic) UIView *introView;
@property (strong, nonatomic) IBOutlet UITableView *tableSuj;
@property (strong, nonatomic) NSMutableArray *listeSujCor;
@property (strong, nonatomic) NSString *intro;


@end
