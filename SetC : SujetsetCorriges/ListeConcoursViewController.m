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

@synthesize pickerViewConcours = _pickerViewConcours;
@synthesize pickerViewFiliere = _pickerViewFiliere;


//définition des tag pour chacun des pickerview pour les reconnaitre
#define kPickerViewConcours 0
#define kPickerViewFiliere 1


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        // Custom initialization
        _concoursTab = [[NSArray alloc]
                        initWithObjects:@"Centrale-Supelec",@"Mines-Ponts",@"CCP",@"Banque PT",@"Baccalaureat",nil];
        
        _filiereBacTab = [[NSArray alloc]
                          initWithObjects:@"ES", @"L", @"S", nil];
        
        _filiereCPGETab = [[NSArray alloc]
                           initWithObjects:@"MP", @"PC", @"PSI", nil];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    

    //définition de hauteurs particulières
    CGRect screenRect = [[UIScreen mainScreen] applicationFrame];
    //CGFloat hauteurFenetre = screenRect.size.height - self.navigationController.navigationBar.frame.size.height - self.tabBarController.tabBar.frame.size.height;
    
    //définition des paramètres de transformation angulaire
    CGAffineTransform rotate = CGAffineTransformMakeRotation(3.14159265*3.5);
    rotate = CGAffineTransformScale(rotate, .25, 2);
    
    //PARTIE PICKERVIEW LOGO
    //initialisaiton du picker view concours
    _pickerViewConcours = [[UIPickerView alloc] initWithFrame:CGRectZero];
    _pickerViewConcours.delegate = self;
    _pickerViewConcours.dataSource = self;
    _pickerViewConcours.backgroundColor = [UIColor clearColor];
    _pickerViewConcours.tag = 0;
    
    //rotation de 90 degres
    [_pickerViewConcours setTransform:rotate];
    
    //indication du centre du picker pour positionner ce dernier dans la vue
    _pickerViewConcours.center = CGPointMake(round(screenRect.size.width/2), round(screenRect.size.height/3));
	[self.view addSubview:_pickerViewConcours];
    
    //création du tableau de logo
    _itemArray = [[NSMutableArray alloc] init];
    [self tabLogoCreation:0];
    
    
    //PARTIE PICKERVIEW FILIERE
    _pickerViewFiliere = [[UIPickerView alloc] initWithFrame:CGRectZero];
    _pickerViewFiliere.delegate = self;
    _pickerViewFiliere.dataSource = self;
    _pickerViewFiliere.backgroundColor = [UIColor clearColor];
    _pickerViewFiliere.tag = 1;
    
    //rotation de 90 degres
    [_pickerViewFiliere setTransform:rotate];
    
    //indication du centre du picker pour positionner ce dernier dans la vue
    _pickerViewFiliere.center = CGPointMake(round(screenRect.size.width/2), round(2*screenRect.size.height/3));
    [self.view addSubview:_pickerViewFiliere];
    
    //création du tableau de filiere
    _filiereArray = [[NSMutableArray alloc] init];
    [self tabFiliereCreation:[_concoursTab objectAtIndex:0]];
    
    
    
}

- (void)tabLogoCreation:(NSInteger)placeLogo
{
    [_itemArray removeAllObjects];
    
    CGRect rect = CGRectMake(0, 0, 100, 100);
    CGRect rectZoom = CGRectMake(0, 0, 150, 150);
    
    UIImageView *tabLogo[[_concoursTab count]];
    CGAffineTransform rotateItem = CGAffineTransformMakeRotation(3.14/2);
    rotateItem = CGAffineTransformScale(rotateItem, 0.35, 2.0);
    
    for (int i=0; i<[_concoursTab count]; i++)
    {
        NSString *path = [[NSBundle mainBundle] pathForResource:[_concoursTab objectAtIndex:i] ofType:@"png"];
        UIImage *imageTemp = [UIImage imageWithContentsOfFile:path];
        tabLogo[i] = [[UIImageView alloc] initWithImage:imageTemp];
        if(i == placeLogo)
            tabLogo[i].frame = rectZoom;
        else
            tabLogo[i].frame = rect;
        tabLogo[i].image = imageTemp;
        tabLogo[i].backgroundColor = [UIColor clearColor];
        tabLogo[i].clipsToBounds = YES;
        
        [tabLogo[i] setTransform:rotateItem];
        
        [_itemArray addObject:tabLogo[i]];
    }
}


- (void)tabFiliereCreation:(NSString*)concours
{
    [_filiereArray removeAllObjects];
    
    CGRect rect = CGRectMake(0, 0, 100, 100);
    CGAffineTransform rotateItem = CGAffineTransformMakeRotation(3.14/2);
    rotateItem = CGAffineTransformScale(rotateItem, 0.25, 2.0);
    UILabel *tabFiliere[3];
    
    if ([concours isEqualToString:@"Baccalaureat"])
    {
        for (int i=0; i<[_filiereBacTab count]; i++)
        {
            tabFiliere[i] = [[UILabel alloc] init];
            tabFiliere[i].text = [_filiereBacTab objectAtIndex:i];
            tabFiliere[i].frame = rect;
            tabFiliere[i].backgroundColor = [UIColor clearColor];
            tabFiliere[i].textAlignment = UITextAlignmentCenter;
            tabFiliere[i].adjustsFontSizeToFitWidth = YES;
            
            UIFont *myFont = [UIFont fontWithName:@"Georgia" size:20];
            [tabFiliere[i] setFont:myFont];
            
            [tabFiliere[i] setTransform:rotateItem];
            
            [_filiereArray addObject:tabFiliere[i]];
        }
    }
    else
    {
        for (int i=0; i<[_filiereCPGETab count]; i++)
        {
            tabFiliere[i] = [[UILabel alloc] init];
            tabFiliere[i].text = [_filiereCPGETab objectAtIndex:i];
            tabFiliere[i].frame = rect;
            tabFiliere[i].backgroundColor = [UIColor clearColor];
            tabFiliere[i].textAlignment = UITextAlignmentCenter;
            tabFiliere[i].adjustsFontSizeToFitWidth = YES;
            
            UIFont *myFont = [UIFont fontWithName:@"Georgia" size:20];
            [tabFiliere[i] setFont:myFont];
            
            [tabFiliere[i] setTransform:rotateItem];
            
            [_filiereArray addObject:tabFiliere[i]];
        }
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
    if (thePickerView.tag == kPickerViewConcours)
        return [_itemArray count];
    else
        return [_filiereArray count];
    
}


- (UIView *)pickerView:(UIPickerView *)thePickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view

{
    if (thePickerView.tag == kPickerViewConcours)
    {
        // Suppression du fond
        for (int i=0;i<5;i++)
        {
            if(i!=2) [(UIView*)[[_pickerViewConcours subviews] objectAtIndex:i] setAlpha:0.0f];
        }
        
        return [_itemArray objectAtIndex: row];
    }
    else
    {
        return [_filiereArray objectAtIndex: row];
    }
    
}



- (void)pickerView:(UIPickerView *)thePickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (thePickerView.tag == kPickerViewConcours)
    {
        //modification du tableau de logo pour mettre en avant le logo sélectionné
        [self tabLogoCreation:row];
        
        //mise à jour du pickerview
        [_pickerViewConcours reloadComponent:component];
        
        [self tabFiliereCreation:[_concoursTab objectAtIndex:row]];
        
        [_pickerViewFiliere reloadAllComponents];
    }

}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 80;
}

/*- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    return 350;
}*/

@end
