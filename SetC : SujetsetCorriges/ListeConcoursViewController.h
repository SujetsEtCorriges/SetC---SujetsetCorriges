//
//  ListeConcoursViewController.h
//  SetC : SujetsetCorriges
//
//  Created by Mestiri Hedi on 14/10/12.
//  Copyright (c) 2012 Mestiri Hedi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ListeConcoursViewController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource>
{
    NSMutableArray *_itemArray;
    NSArray *_concoursTab;
}

@property (strong, nonatomic)  UIPickerView *pickerView;

@end
