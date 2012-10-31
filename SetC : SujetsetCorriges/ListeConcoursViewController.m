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

@synthesize pickerViewConcours = pickerViewConcours_;
@synthesize pickerViewFiliere = pickerViewFiliere_;


//définition des tag pour chacun des pickerview pour les reconnaitre
#define kPickerViewConcours 0
#define kPickerViewFiliere 1


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        // Custom initialization
        concoursTab_ = [[NSArray alloc]
                        initWithObjects:@"Centrale-Supelec",@"Mines-Ponts",@"CCP",@"Banque PT",@"Baccalaureat",nil];
        
        filiereBacTab_ = [[NSArray alloc]
                          initWithObjects:@"ES", @"L", @"S", nil];
        
        filiereCPGETab_ = [[NSArray alloc]
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
    pickerViewConcours_ = [[UIPickerView alloc] initWithFrame:CGRectZero];
    pickerViewConcours_.delegate = self;
    pickerViewConcours_.dataSource = self;
    pickerViewConcours_.backgroundColor = [UIColor clearColor];
    pickerViewConcours_.tag = 0;
    
    //rotation de 90 degres
    [pickerViewConcours_ setTransform:rotate];
    
    //indication du centre du picker pour positionner ce dernier dans la vue
    pickerViewConcours_.center = CGPointMake(round(screenRect.size.width/2), round(screenRect.size.height/3));
	[self.view addSubview:pickerViewConcours_];
    
    //création du tableau de logo
    itemArray_ = [[NSMutableArray alloc] init];
    [self tabLogoCreation:0];
    
    
    //PARTIE PICKERVIEW FILIERE
    pickerViewFiliere_ = [[UIPickerView alloc] initWithFrame:CGRectZero];
    pickerViewFiliere_.delegate = self;
    pickerViewFiliere_.dataSource = self;
    pickerViewFiliere_.backgroundColor = [UIColor clearColor];
    pickerViewFiliere_.tag = 1;
    
    //rotation de 90 degres
    [pickerViewFiliere_ setTransform:rotate];
    
    //indication du centre du picker pour positionner ce dernier dans la vue
    pickerViewFiliere_.center = CGPointMake(round(screenRect.size.width/2), round(2*screenRect.size.height/3));
    [self.view addSubview:pickerViewFiliere_];
    
    //création du tableau de filiere
    filiereArray_ = [[NSMutableArray alloc] init];
    [self tabFiliereCreation:[concoursTab_ objectAtIndex:0]];
    
    
    
}

- (void)tabLogoCreation:(NSInteger)theNumeroLogo
{
    [itemArray_ removeAllObjects];
    
    CGRect rect = CGRectMake(0, 0, 100, 100);
    CGRect rectZoom = CGRectMake(0, 0, 150, 150);
    
    UIImageView *tabLogo[[concoursTab_ count]];
    CGAffineTransform rotateItem = CGAffineTransformMakeRotation(3.14/2);
    rotateItem = CGAffineTransformScale(rotateItem, 0.35, 2.0);
    
    for (int i=0; i<[concoursTab_ count]; i++)
    {
        NSString *path = [[NSBundle mainBundle] pathForResource:[concoursTab_ objectAtIndex:i] ofType:@"png"];
        UIImage *imageTemp = [UIImage imageWithContentsOfFile:path];
        tabLogo[i] = [[UIImageView alloc] initWithImage:imageTemp];
        if(i == theNumeroLogo)
            tabLogo[i].frame = rectZoom;
        else
            tabLogo[i].frame = rect;
        tabLogo[i].image = imageTemp;
        tabLogo[i].backgroundColor = [UIColor clearColor];
        tabLogo[i].clipsToBounds = YES;
        
        [tabLogo[i] setTransform:rotateItem];
        
        [itemArray_ addObject:tabLogo[i]];
    }
}


- (void)tabFiliereCreation:(NSString*)theConcours
{
    [filiereArray_ removeAllObjects];
    
    CGRect rect = CGRectMake(0, 0, 100, 100);
    CGAffineTransform rotateItem = CGAffineTransformMakeRotation(3.14/2);
    rotateItem = CGAffineTransformScale(rotateItem, 0.25, 2.0);
    UILabel *tabFiliere[3];
    
    if ([theConcours isEqualToString:@"Baccalaureat"])
    {
        for (int i=0; i<[filiereBacTab_ count]; i++)
        {
            tabFiliere[i] = [[UILabel alloc] init];
            tabFiliere[i].text = [filiereBacTab_ objectAtIndex:i];
            tabFiliere[i].frame = rect;
            tabFiliere[i].backgroundColor = [UIColor clearColor];
            tabFiliere[i].textAlignment = UITextAlignmentCenter;
            tabFiliere[i].adjustsFontSizeToFitWidth = YES;
            
            UIFont *myFont = [UIFont fontWithName:@"Georgia" size:20];
            [tabFiliere[i] setFont:myFont];
            
            [tabFiliere[i] setTransform:rotateItem];
            
            [filiereArray_ addObject:tabFiliere[i]];
        }
    }
    else
    {
        for (int i=0; i<[filiereCPGETab_ count]; i++)
        {
            tabFiliere[i] = [[UILabel alloc] init];
            tabFiliere[i].text = [filiereCPGETab_ objectAtIndex:i];
            tabFiliere[i].frame = rect;
            tabFiliere[i].backgroundColor = [UIColor clearColor];
            tabFiliere[i].textAlignment = UITextAlignmentCenter;
            tabFiliere[i].adjustsFontSizeToFitWidth = YES;
            
            UIFont *myFont = [UIFont fontWithName:@"Georgia" size:20];
            [tabFiliere[i] setFont:myFont];
            
            [tabFiliere[i] setTransform:rotateItem];
            
            [filiereArray_ addObject:tabFiliere[i]];
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
        return [itemArray_ count];
    else
        return [filiereArray_ count];
    
}


- (UIView *)pickerView:(UIPickerView *)thePickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view

{
    if (thePickerView.tag == kPickerViewConcours)
    {
        // Suppression du fond
        for (int i=0;i<5;i++)
        {
            if(i!=2) [(UIView*)[[pickerViewConcours_ subviews] objectAtIndex:i] setAlpha:0.0f];
        }
        
        return [itemArray_ objectAtIndex: row];
    }
    else
    {
        return [filiereArray_ objectAtIndex: row];
    }
    
}



- (void)pickerView:(UIPickerView *)thePickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (thePickerView.tag == kPickerViewConcours)
    {
        //modification du tableau de logo pour mettre en avant le logo sélectionné
        [self tabLogoCreation:row];
        
        //mise à jour du pickerview
        [pickerViewConcours_ reloadComponent:component];
        
        [self tabFiliereCreation:[concoursTab_ objectAtIndex:row]];
        
        [pickerViewFiliere_ reloadAllComponents];
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
