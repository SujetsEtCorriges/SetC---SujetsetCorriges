//
//  ActuCell.m
//  SetC : SujetsetCorriges
//
//  Created by Mestiri Hedi on 09/09/12.
//  Copyright (c) 2012 Mestiri Hedi. All rights reserved.
//

#import "ActuCell.h"

@implementation ActuCell
@synthesize titreCell = titreCell_;
@synthesize dateCell = dateCell_;
@synthesize imageCell = imageCell_;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        //indication de la largeur des differentes parties de la cellule
        CGFloat largeurLogo = round(self.frame.size.width/6);
        CGFloat largeurDate = round(self.frame.size.width/7);
        
        //configuration de la date de la cellule
        dateCell_ = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width-largeurDate, 0, largeurDate, self.frame.size.height)];
        dateCell_.font = [UIFont fontWithName:@"Arial" size:12.0];
        dateCell_.textAlignment = UITextAlignmentCenter;
        
        
        //configuration du titre de la cellule
        titreCell_ = [[UILabel alloc] initWithFrame:CGRectMake(largeurLogo, 0, self.frame.size.width-largeurLogo-largeurDate, self.frame.size.height)];
        titreCell_.font = [UIFont fontWithName:@"Arial" size:14.0];
        titreCell_.textColor = [UIColor colorWithRed:0.07 green:0.07 blue:0.07 alpha:1.0];
        
        
        [self.contentView addSubview:dateCell_];
        [self.contentView addSubview:titreCell_];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
