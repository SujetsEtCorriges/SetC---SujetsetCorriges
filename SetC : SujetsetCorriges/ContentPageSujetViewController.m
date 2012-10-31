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

@synthesize tableSuj = tableSuj_;
@synthesize listeSujCor = listeSujCor_;
@synthesize intro = intro_;
@synthesize introView = introView_;

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
    
    if ([intro_ isEqualToString:@"intro"])
    {
        [tableSuj_ setHidden:YES];
        
        CGRect screenRect = [[UIScreen mainScreen] applicationFrame];
        CGFloat hauteurFenetre = screenRect.size.height - self.navigationController.navigationBar.frame.size.height - self.tabBarController.tabBar.frame.size.height;
        
        introView_ = [[UIView alloc] initWithFrame:CGRectMake(0,0,self.view.frame.size.width, hauteurFenetre)];
        
        introLabel_ = [[UILabel alloc] initWithFrame:CGRectMake(0, round(introView_.frame.size.height/3), introView_.frame.size.width, round(introView_.frame.size.height/3))];
        introLabel_.text = @"Sélectionnez un concours";
        introLabel_.textAlignment = UITextAlignmentCenter;
        
        [introView_ addSubview:introLabel_];
        [self.view addSubview:introView_];
    }
    else
    {
        CGRect screenRect = [[UIScreen mainScreen] applicationFrame];
        //CGFloat hauteurFenetre = screenRect.size.height - self.navigationController.navigationBar.frame.size.height - self.tabBarController.tabBar.frame.size.height;
        
        //initialisation des variables
        NSDictionary *tempSujCor = [[NSDictionary alloc] init];
        NSString *tempAnnee = [[NSString alloc] init];
        NSMutableArray *listAnnee = [[NSMutableArray alloc] init];
        tabSujCorRangeParAnnee_ = [[NSMutableDictionary alloc] init];
        
        //booléen pour savoir si l'annee a déjà été rencontré
        BOOL found = NO;
        
        //tableau des années extraites
        for (int i=0; i<[listeSujCor_ count]; i++)
        {
            //on prend l'entrée et on enregistre la matière
            tempSujCor = [listeSujCor_ objectAtIndex:i];
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

                //on créé un tableau qui contiendra les épreuves pour l'année correspondante
                NSMutableArray *tabEpreuves = [[NSMutableArray alloc] init];
                
                //on ajoute l'élément XML actuel dans le tableau d'ID
                [tabEpreuves addObject:tempSujCor];
                
                //on ajoute dans le dictionnaire le tableau d'epreuve avec pour clé l'annee actuelle
                [tabSujCorRangeParAnnee_ setObject:tabEpreuves forKey:tempAnnee];

                found = NO;
            }
            else
            {
                //l'annee existe, un tableau d'épreuve existe pour cette année, on l'enregistre
                NSMutableArray *tabEpreuves = [[NSMutableArray alloc] init];
                tabEpreuves = [tabSujCorRangeParAnnee_ objectForKey:tempAnnee];
                
                //on rajoute à ce tableau l'épreuve actuel
                [tabEpreuves addObject:tempSujCor];
                
                //on remplace l'ancien tableau d'élément par le nouveau dans le dictionnaire
                [tabSujCorRangeParAnnee_ setObject:tabEpreuves forKey:tempAnnee];
                
                found = NO;
            }
        }
        
        //trier tableau annee dans l'ordre croissant
        NSSortDescriptor* sortOrder = [NSSortDescriptor sortDescriptorWithKey: @"self" ascending: NO];
        tabAnneeOrdre_ = [listAnnee sortedArrayUsingDescriptors: [NSArray arrayWithObject: sortOrder]];

        tableSuj_.delegate = self;
        tableSuj_.dataSource = self;
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
    return [tabAnneeOrdre_ count];
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [tabAnneeOrdre_ objectAtIndex:section];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[tabSujCorRangeParAnnee_ objectForKey:[tabAnneeOrdre_ objectAtIndex:section]] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    NSDictionary *sujcor = [[tabSujCorRangeParAnnee_ objectForKey:[tabAnneeOrdre_ objectAtIndex:[indexPath section]]] objectAtIndex:[indexPath row]];
    cell.textLabel.text = [NSString stringWithFormat:@"%@ - %@", [sujcor objectForKey:kNom], [sujcor objectForKey:kEpreuve]];
    
    return cell;
}

@end
