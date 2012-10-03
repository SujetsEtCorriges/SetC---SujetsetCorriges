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
    UIView *sujCorView;
}

@property (strong, nonatomic) IBOutlet UIWebView *webView;
@property (strong, nonatomic) IBOutlet UITableView *tableSuj;
@property (strong, nonatomic) id dataObject;
@property (strong, nonatomic) NSMutableArray *listeSujCor;


@end
