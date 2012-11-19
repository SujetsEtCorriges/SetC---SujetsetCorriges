//
//  DetailEpreuveViewController.m
//  SetC : SujetsetCorriges
//
//  Created by Jérémy on 18/11/12.
//  Copyright (c) 2012 Mestiri Hedi. All rights reserved.
//

#import "DetailEpreuveViewController.h"

@interface DetailEpreuveViewController ()

@end

@implementation DetailEpreuveViewController

@synthesize lienSujet = lienSujet_;
@synthesize lienCorrige = lienCorrige_;
@synthesize concours = concours_;
@synthesize annee = annee_;
@synthesize filiere = filiere_;
@synthesize epreuve = epreuve_;
@synthesize corrigePartiel = corrigePartiel_;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"Résumé";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    labelConcours = [[UILabel alloc] initWithFrame:CGRectMake(50, 50, 220, 20)];
    labelConcours.textAlignment = UITextAlignmentCenter;
    labelConcours.text = concours_;
    [self.view addSubview:labelConcours];
    
    labelFiliere = [[UILabel alloc] initWithFrame:CGRectMake(50, 80, 220, 20)];
    labelFiliere.textAlignment = UITextAlignmentCenter;
    labelFiliere.text = filiere_;
    [self.view addSubview:labelFiliere];
    
    labelAnnee = [[UILabel alloc] initWithFrame:CGRectMake(50, 110, 220, 20)];
    labelAnnee.textAlignment = UITextAlignmentCenter;
    labelAnnee.text = annee_;
    [self.view addSubview:labelAnnee];
    
    labelEpreuve = [[UILabel alloc] initWithFrame:CGRectMake(50, 140, 220, 20)];
    labelEpreuve.textAlignment = UITextAlignmentCenter;
    labelEpreuve.text = epreuve_;
    [self.view addSubview:labelEpreuve];
    
    boutonSujet = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    boutonSujet.frame = CGRectMake(20, 200, 130, 50);
    [boutonSujet setTitle:@"Sujet" forState:UIControlStateNormal];
    [boutonSujet addTarget:self
                    action:@selector(montrerFichier)
                    forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:boutonSujet];
    
    boutonCorrige = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    boutonCorrige.frame = CGRectMake(170, 200, 130, 50);
    [boutonCorrige setTitle:@"Corrigé" forState:UIControlStateNormal];
    [boutonCorrige addTarget:self
                    action:@selector(montrerFichier)
          forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:boutonCorrige];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)montrerFichier
{
    // On charge la webview
}

@end
