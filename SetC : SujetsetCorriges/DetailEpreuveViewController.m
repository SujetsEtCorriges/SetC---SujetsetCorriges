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

@synthesize lienSujet, lienCorrige, concours, filiere, epreuve;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    boutonSujet = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    boutonSujet.frame = CGRectMake(20, 200, 100, 50);
    [boutonSujet setTitle:@"Sujet" forState:UIControlStateNormal];
    [boutonSujet addTarget:self
                    action:@selector(montrerFichier)
                    forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:boutonSujet];
    
    boutonCorrige = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    boutonCorrige.frame = CGRectMake(200, 200, 100, 50);
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
