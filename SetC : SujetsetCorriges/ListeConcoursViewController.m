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
    
    //scrollViewConcours_ = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 100, 320, 60)];
    //scrollViewConcours_.showsHorizontalScrollIndicator = NO;
    //scrollViewConcours_.pagingEnabled = YES;
    
    CGFloat paperWidth = 320;
    NSUInteger numberOfPapers = [concoursTab_ count];
    for (NSUInteger i = 0; i < numberOfPapers; i++)
    {
        //UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake((paperWidth)*i, 0, paperWidth, scrollViewConcours_.bounds.size.height)];
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake((paperWidth)*i + 110, 0, 100, 100)];
        
        NSString *path = [[NSBundle mainBundle] pathForResource:[concoursTab_ objectAtIndex:i] ofType:@"png"];
        UIImage *imageTemp = [UIImage imageWithContentsOfFile:path];
        
        imageView.image = imageTemp;
        [scrollViewConcours_ addSubview:imageView];
    }
    
    CGSize contentSize = CGSizeMake((paperWidth)*numberOfPapers, scrollViewConcours_.bounds.size.height);
    scrollViewConcours_.contentSize = contentSize;
    
    //CGPoint offsetScroll = CGPointMake(130, 0);
    //scrollViewConcours_.contentOffset = offsetScroll;
    
    [self.view addSubview:scrollViewConcours_];

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

@end
