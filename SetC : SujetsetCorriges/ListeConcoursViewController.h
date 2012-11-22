//
//  ListeConcoursViewController.h
//  SetC : SujetsetCorriges
//
//  Created by Mestiri Hedi on 14/10/12.
//  Copyright (c) 2012 Mestiri Hedi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ListeConcoursViewController : UIViewController <UIScrollViewDelegate, UIScrollViewAccessibilityDelegate>
{
    NSMutableArray *itemArray_;
    NSArray *concoursTab_;
    
    NSMutableArray *filiereArray_;
    NSArray *filiereBacTab_;
    NSArray *filiereCPGETab_;
    
    UIScrollView *scrollViewConcours_;
}

@end
