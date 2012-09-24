//
//  CommentsViewController.h
//  SetC : SujetsetCorriges
//
//  Created by Jérémy on 23/09/12.
//  Copyright (c) 2012 Mestiri Hedi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PullToRefreshView.h"
#import "KMXMLParser.h"
#import "CommentCell.h"

@interface CommentsViewController : UIViewController <UITableViewDataSource,UITableViewDelegate>
{
    UITableView *commentsTableView;
    NSArray *_dataToShow;
}

@property(strong, nonatomic) NSMutableArray *parseResults;
@property(strong, nonatomic) NSString *url;

@end
