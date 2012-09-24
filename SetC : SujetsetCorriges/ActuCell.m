//
//  ActuCell.m
//  SetC : SujetsetCorriges
//
//  Created by Mestiri Hedi on 09/09/12.
//  Copyright (c) 2012 Mestiri Hedi. All rights reserved.
//

#import "ActuCell.h"

@implementation ActuCell
@synthesize titreCell = _titreCell, dateCell = _dateCell, imageCell = _imageCell;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        //indication de la largeur des differentes parties de la cellule
        CGFloat largeurLogo = round(self.frame.size.width/6);
        CGFloat largeurDate = round(self.frame.size.width/7);
        
        //configuration de la date de la cellule
        _dateCell = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width-largeurDate, 0, largeurDate, self.frame.size.height)];
        _dateCell.font = [UIFont fontWithName:@"Arial" size:12.0];
        _dateCell.textAlignment = UITextAlignmentCenter;
        
        
        //configuration du titre de la cellule
        _titreCell = [[UILabel alloc] initWithFrame:CGRectMake(largeurLogo, 0, self.frame.size.width-largeurLogo-largeurDate, self.frame.size.height)];
        _titreCell.font = [UIFont fontWithName:@"Arial" size:14.0];
        _titreCell.textColor = [UIColor colorWithRed:0.07 green:0.07 blue:0.07 alpha:1.0];
        
        
        [self.contentView addSubview:_dateCell];
        [self.contentView addSubview:_titreCell];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
