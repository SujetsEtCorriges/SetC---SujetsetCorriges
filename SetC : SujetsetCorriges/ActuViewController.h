//
//  ActuViewController.h
//  SetC : SujetsetCorriges
//
//  Created by Mestiri Hedi on 09/09/12.
//  Copyright (c) 2012 Mestiri Hedi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ActuDetailViewController.h"
#import "PullToRefreshView.h"
#import "XMLParser.h"
#import "MBProgressHUD.h"

@interface ActuViewController : UITableViewController <PullToRefreshViewDelegate, XMLParserDelegate>
{
    NSMutableArray *newsData_;
    
    XMLParser *parser_;
}

@end
