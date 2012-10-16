//
//  ListeConcoursViewController.m
//  SetC : SujetsetCorriges
//
//  Created by Mestiri Hedi on 14/10/12.
//  Copyright (c) 2012 Mestiri Hedi. All rights reserved.
//

#import "ListeConcoursViewController.h"

@interface ListeConcoursViewController ()

@end

@implementation ListeConcoursViewController

@synthesize pickerView = _pickerView;



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    // set the pickerview delegate to itself. This is important because if you don't set
    // this, then the delegate functions will not work/be called.
    _pickerView.delegate = self;
    
    // here is where the customization lies: CGAffineTransform is a way to transform
    // object according to scale and rotation. Here we rotate the pickerview by PI/2
    // which is 90 degrees in radians. Then we concat the rotation transform with
    // scale transform, and finally setting the pickerview transform.
    
    CGAffineTransform rotate = CGAffineTransformMakeRotation(3.14/2);
    rotate = CGAffineTransformScale(rotate, 0.1, 0.8);
    
    [_pickerView setTransform:rotate];
    
    // set the center location
    _pickerView.center = CGPointMake(160,75);
    
    // Here I decided to add UILabel as the item's "object"
    // you can use ANYTHING here, like UIImageViews or any class of UIView
    // Since we rotate the pickerview in one direction, we need to compensate
    // the item's angle by counter rotating it in the opposite direction,
    // and adjust the scale as well. You may need to try a few times to get
    // the right/suitable size as for the scale.
    
    UILabel *theview[20];
    CGAffineTransform rotateItem = CGAffineTransformMakeRotation(-3.14/2);
    rotateItem = CGAffineTransformScale(rotateItem, 1, 10);
    
    // next alloc and create the views in a loop. here I decided to have 20
    // UIlabels, each with a text of 1 to 20. Set the other UIlabel's property as you wish.
    
    for (int i=0;i<20;i++)
    {
        theview[i] = [[UILabel alloc] init];
        theview[i].text = [NSString stringWithFormat:@"%d",i];
        theview[i].textColor = [UIColor blackColor];
        theview[i].frame = CGRectMake(0,0, 100, 100);
        theview[i].backgroundColor = [UIColor clearColor];
        theview[i].textAlignment = UITextAlignmentCenter;
        theview[i].shadowColor = [UIColor whiteColor];
        theview[i].shadowOffset = CGSizeMake(-1,-1);
        theview[i].adjustsFontSizeToFitWidth = YES;
        
        UIFont *myFont = [UIFont fontWithName:@"Georgia" size:15];
        [theview[i] setFont:myFont];
        theview[i].transform = rotateItem;
    }
    
    // then we initialize and create our NSMutableArray, and add all 20 UIlabel views
    // that we just created above into the array using "addObject" method.
    itemArray = [[NSMutableArray alloc] init];  
    for (int j=0;j<20;j++)
    {
        [itemArray addObject:theview[j]];  
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



//picker view
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)thePickerView {
    
    return 1;
    
}

- (NSInteger)pickerView:(UIPickerView *)thePickerView numberOfRowsInComponent:(NSInteger)component {
    
    return [itemArray count];
    
}


- (UIView *)pickerView:(UIPickerView *)thePickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view

{
    
    return [itemArray objectAtIndex: row];
    
}

- (void)pickerView:(UIPickerView *)thePickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    
    
}

@end
