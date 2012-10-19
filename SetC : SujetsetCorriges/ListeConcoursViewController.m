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
        _concoursTab = [[NSArray alloc]
                        initWithObjects:@"Centrale-Supelec",@"Mines-Ponts",@"CCP",@"Banque PT",@"Baccalaureat",nil];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    

    //définition de hauteurs particulières
    CGRect screenRect = [[UIScreen mainScreen] applicationFrame];
    CGFloat hauteurFenetre = screenRect.size.height - self.navigationController.navigationBar.frame.size.height - self.tabBarController.tabBar.frame.size.height;
    
    
    // set the pickerview delegate to itself. This is important because if you don't set
    // this, then the delegate functions will not work/be called.
    //_pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0,0, screenRect.size.width, round(hauteurFenetre/3))];
    _pickerView = [[UIPickerView alloc] initWithFrame:CGRectZero];
    _pickerView.delegate = self;
    _pickerView.dataSource = self;
    _pickerView.backgroundColor = [UIColor clearColor];
    
    CGAffineTransform rotate = CGAffineTransformMakeRotation(3.14159265*3.5);
    rotate = CGAffineTransformScale(rotate, .25, 2);
    [_pickerView setTransform:rotate];
    
    
    _pickerView.center = CGPointMake(round(screenRect.size.width/2), round(screenRect.size.width/2));
	// Add it to your view
	[self.view addSubview:_pickerView];
    
    
    

    CGRect rect = CGRectMake(0, 0, 60, 60);
    
    UIImageView *tabLogo[[_concoursTab count]];
    CGAffineTransform rotateItem = CGAffineTransformMakeRotation(3.14/2);
    rotateItem = CGAffineTransformScale(rotate, -2, -2);
    for (int i=0; i<[_concoursTab count]; i++)
    {
        NSString *path = [[NSBundle mainBundle] pathForResource:[_concoursTab objectAtIndex:i] ofType:@"png"];
        //UIImage *imageTemp = [UIImage imageNamed:@"CCP.png"];
        UIImage *imageTemp = [UIImage imageWithContentsOfFile:path];
        tabLogo[i] = [[UIImageView alloc] initWithImage:imageTemp];
        tabLogo[i].frame = rect;
        tabLogo[i].image = imageTemp;
        tabLogo[i].backgroundColor = [UIColor clearColor];
        tabLogo[i].clipsToBounds = YES;

        [tabLogo[i] setTransform:rotateItem];
    }
    
    // then we initialize and create our NSMutableArray, and add all 20 UIlabel views
    // that we just created above into the array using "addObject" method.
    _itemArray = [[NSMutableArray alloc] init];
    for (int j=0;j<[_concoursTab count];j++)
    {
        [_itemArray addObject:tabLogo[j]];
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



//picker view
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)thePickerView
{
    
    return 1;
    
}

- (NSInteger)pickerView:(UIPickerView *)thePickerView numberOfRowsInComponent:(NSInteger)component
{
    
    return [_itemArray count];
    
}


- (UIView *)pickerView:(UIPickerView *)thePickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view

{
    // Suppression du fond
    for (int i=0;i<5;i++)
    {
        if(i!=2) [(UIView*)[[_pickerView subviews] objectAtIndex:i] setAlpha:0.0f];
    }
    
    return [_itemArray objectAtIndex: row];
    
}

- (void)pickerView:(UIPickerView *)thePickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    
    
    
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 80;
}

//- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
//{
//    return 800;
//}

@end
