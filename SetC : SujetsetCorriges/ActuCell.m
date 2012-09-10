//
//  ActuCell.m
//  SetC : SujetsetCorriges
//
//  Created by Mestiri Hedi on 09/09/12.
//  Copyright (c) 2012 Mestiri Hedi. All rights reserved.
//

#import "ActuCell.h"

@implementation ActuCell
@synthesize cellLabel = _cellLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        // Initialization code
        _cellLabel = [[UILabel alloc] initWithFrame:self.frame];
        _cellLabel.font = [UIFont fontWithName:@"Courier-Bold" size:12.0];
        _cellLabel.textAlignment = UITextAlignmentCenter;
        _cellLabel.textColor = [UIColor redColor];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
