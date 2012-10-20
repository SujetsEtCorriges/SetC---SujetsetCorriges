//
//  CommentsViewController.h
//  SetC : SujetsetCorriges
//
//  Created by Jérémy on 23/09/12.
//  Copyright (c) 2012 Mestiri Hedi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PullToRefreshView.h"
#import "XMLParser.h"
#import "MBProgressHUD.h"
#import "CommentCell.h"
#import "RedactionCommentViewController.h"

@interface CommentsViewController : UIViewController <UITableViewDataSource,UITableViewDelegate, XMLParserDelegate, PullToRefreshViewDelegate>
{
    UITableView *_commentsTableView;
    NSMutableArray *_commentsData;
    
    XMLParser *_parser;
}

@property(strong, nonatomic) NSString *url;

@end
