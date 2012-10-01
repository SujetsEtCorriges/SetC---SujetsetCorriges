//
//  CommentCell.m
//  SetC : SujetsetCorriges
//
//  Created by Jérémy on 24/09/12.
//  Copyright (c) 2012 Mestiri Hedi. All rights reserved.
//

#import "CommentCell.h"

@implementation CommentCell
@synthesize pseudoLabel = _pseudoLabel, messageLabel = _messageLabel, dateLabel = _dateLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {        
        //configuration de la date de la cellule
        _dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(220, 5, 100, 10)];
        _dateLabel.font = [UIFont fontWithName:@"Arial" size:12.0];
        _dateLabel.textAlignment = UITextAlignmentCenter;
        
        //configuration du pseudo de la cellule
        _pseudoLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 0, 210, 20)];
        _pseudoLabel.font = [UIFont fontWithName:@"Arial" size:14.0];
        //_pseudoLabel.textColor = [UIColor colorWithRed:0.07 green:0.07 blue:0.07 alpha:1.0];
        
        //configuration du message de la cellule
        _messageLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 15, 300, 10)];
        _messageLabel.font = [UIFont fontWithName:@"Arial" size:14.0];
        //_messageLabel.textColor = [UIColor colorWithRed:0.07 green:0.07 blue:0.07 alpha:1.0];
        
        
        [self.contentView addSubview:_dateLabel];
        [self.contentView addSubview:_pseudoLabel];
        [self.contentView addSubview:_messageLabel];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
