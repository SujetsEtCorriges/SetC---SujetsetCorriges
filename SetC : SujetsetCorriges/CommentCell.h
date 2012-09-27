//
//  CommentCell.h
//  SetC : SujetsetCorriges
//
//  Created by Jérémy on 24/09/12.
//  Copyright (c) 2012 Mestiri Hedi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommentCell : UITableViewCell

@property (nonatomic, strong) UILabel *pseudoLabel;
@property (nonatomic, strong) UILabel *messageLabel;
@property (nonatomic, strong) UILabel *dateLabel;

@end
