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
//#import "KMXMLParser.h"
#import "XMLParser.h"
#import "MBProgressHUD.h"

@interface ActuViewController : UITableViewController <KMXMLParserDelegate, PullToRefreshViewDelegate, XMLParserDelegate>
{
    NSArray *_dataToShow;
    
    XMLParser *_parser;
}

@property(strong, nonatomic) NSMutableArray *parseResults;

@end
