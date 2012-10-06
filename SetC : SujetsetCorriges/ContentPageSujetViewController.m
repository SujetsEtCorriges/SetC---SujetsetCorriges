//
//  ContentPageSujetViewController.m
//  SetC : SujetsetCorriges
//
//  Created by Mestiri Hedi on 29/09/12.
//  Copyright (c) 2012 Mestiri Hedi. All rights reserved.
//

#import "ContentPageSujetViewController.h"

@interface ContentPageSujetViewController ()

@end

@implementation ContentPageSujetViewController

@synthesize tableSuj;
@synthesize listeSujCor = _listeSujCor;
@synthesize intro = _intro;
@synthesize introView = _introView;

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
    if ([_intro isEqualToString:@"intro"])
    {
        CGRect screenRect = [[UIScreen mainScreen] applicationFrame];
        CGFloat hauteurFenetre = screenRect.size.height - self.navigationController.navigationBar.frame.size.height - self.tabBarController.tabBar.frame.size.height;
        
        _introView = [[UIView alloc] initWithFrame:CGRectMake(0,0,self.view.frame.size.width, hauteurFenetre)];
        
        introLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, round(_introView.frame.size.height/3), _introView.frame.size.width, round(_introView.frame.size.height/3))];
        introLabel.text = @"Sélectionnez un concours";
        introLabel.textAlignment = UITextAlignmentCenter;
        
        [_introView addSubview:introLabel];
        [self.view addSubview:_introView];
    }
    else
    {
        CGRect screenRect = [[UIScreen mainScreen] applicationFrame];
        CGFloat hauteurFenetre = screenRect.size.height - self.navigationController.navigationBar.frame.size.height - self.tabBarController.tabBar.frame.size.height;
        
        //initialisation des variables
        NSDictionary *tempSujCor = [[NSDictionary alloc] init];
        NSString *tempAnnee = [[NSString alloc] init];
        NSMutableArray *listAnnee = [[NSMutableArray alloc] init];
        tabSujCorRangeParAnnee = [[NSMutableDictionary alloc] init];
        
        //booléen pour savoir si l'annee a déjà été rencontré
        BOOL found = NO;
        
        //tableau des années extraites
        for (int i=0; i<[_listeSujCor count]; i++)
        {
            //on prend l'entrée et on enregistre la matière
            tempSujCor = [_listeSujCor objectAtIndex:i];
            tempAnnee = [tempSujCor objectForKey:@"annee"];

            //on recherche si la matière est dans le tableau
            for (NSString *mat in listAnnee)
            {
                if ([mat isEqualToString:tempAnnee])
                {
                    found = YES;
                    break;
                }
            }
            
            //si l'année n'a pas été trouvé
            if (!found)
            {
                //on ajoute l'année dans le tableau
                [listAnnee addObject:tempAnnee];
                NSLog(@"%@", tempAnnee);
                //on créé un tableau qui contiendra les épreuves pour l'année correspondante
                NSMutableArray *tabEpreuves = [[NSMutableArray alloc] init];
                
                //on ajoute l'élément XML actuel dans le tableau d'ID
                [tabEpreuves addObject:tempSujCor];
                
                //on ajoute dans le dictionnaire le tableau d'epreuve avec pour clé l'annee actuelle
                [tabSujCorRangeParAnnee setObject:tabEpreuves forKey:tempAnnee];

                found = NO;
            }
            else
            {
                //l'annee existe, un tableau d'épreuve existe pour cette année, on l'enregistre
                NSMutableArray *tabEpreuves = [[NSMutableArray alloc] init];
                tabEpreuves = [tabSujCorRangeParAnnee objectForKey:tempAnnee];
                
                //on rajoute à ce tableau l'épreuve actuel
                [tabEpreuves addObject:tempSujCor];
                
                //on remplace l'ancien tableau d'élément par le nouveau dans le dictionnaire
                [tabSujCorRangeParAnnee setObject:tabEpreuves forKey:tempAnnee];
                
                found = NO;
            }
        }
        
        //trier tableau annee dans l'ordre croissant
        NSArray *unsortedArray = tabSujCorRangeParAnnee.allKeys;
        NSSortDescriptor* sortOrder = [NSSortDescriptor sortDescriptorWithKey: @"self" ascending: NO];
        tabAnneeOrdre = [unsortedArray sortedArrayUsingDescriptors: [NSArray arrayWithObject: sortOrder]];

        
        tableSuj = [[UITableView alloc] initWithFrame:CGRectMake(0,0,self.view.frame.size.width, hauteurFenetre) style:UITableViewStyleGrouped];
        tableSuj.delegate = self;
        tableSuj.dataSource = self;
        [self.view addSubview:tableSuj];
        
        
    }

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [tabAnneeOrdre count];
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [tabAnneeOrdre objectAtIndex:section];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[tabSujCorRangeParAnnee objectForKey:[tabAnneeOrdre objectAtIndex:section]] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    NSDictionary *sujcor = [[tabSujCorRangeParAnnee objectForKey:[tabAnneeOrdre objectAtIndex:[indexPath section]]] objectAtIndex:[indexPath row]];
    cell.textLabel.text = [NSString stringWithFormat:@"%@ - %@", [sujcor objectForKey:kMatiere], [sujcor objectForKey:kEpreuve]];
    
    return cell;
}

@end
