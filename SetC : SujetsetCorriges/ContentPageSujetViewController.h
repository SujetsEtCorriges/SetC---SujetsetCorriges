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
    UILabel *introLabel_;
    
    NSMutableDictionary *tabSujCorRangeParAnnee_;
    NSArray *tabAnneeOrdre_;
    
    NSArray *tabFiliere_;
}

@property (strong, nonatomic) UIView *introView;
@property (strong, nonatomic) IBOutlet UITableView *tableSuj;
@property (strong, nonatomic) NSMutableArray *listeSujCor;
@property (assign, nonatomic) BOOL intro;
@property (strong, nonatomic) NSString *concours;
@property (strong, nonatomic) NSString *filiere;


@end
