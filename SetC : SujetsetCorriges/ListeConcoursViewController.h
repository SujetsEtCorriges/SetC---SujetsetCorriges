//
//  ListeConcoursViewController.h
//  SetC : SujetsetCorriges
//
//  Created by Mestiri Hedi on 14/10/12.
//  Copyright (c) 2012 Mestiri Hedi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ListeConcoursViewController : UIViewController <UIPickerViewDelegate>
{
    NSMutableArray *itemArray;
}

@property (strong, nonatomic)  IBOutlet UIPickerView *pickerView;

@end
