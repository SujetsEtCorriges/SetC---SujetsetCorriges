//
//  SectionListViewController.h
//  SetC : SujetsetCorriges
//
//  Created by Mestiri Hedi on 09/09/12.
//  Copyright (c) 2012 Mestiri Hedi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SectionListViewController : UITableViewController
{
    NSDictionary *listeSection;
}

@property (strong, nonatomic) NSString *concours;

@end
