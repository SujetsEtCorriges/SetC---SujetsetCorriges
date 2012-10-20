//
//  RedactionCommentViewController.m
//  SetC : SujetsetCorriges
//
//  Created by Jérémy on 20/10/12.
//  Copyright (c) 2012 Mestiri Hedi. All rights reserved.
//

#import "RedactionCommentViewController.h"

@interface RedactionCommentViewController ()

@end

@implementation RedactionCommentViewController

@synthesize idArticle = _idArticle;

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
    
    self.navigationItem.title = @"Rédiger un commentaire";
    
    //Label dans la NavigationBar
//    UILabel *labelTitre = [[UILabel alloc] init];
//    labelTitre.text = navItem.title;
//    labelTitre.font = [UIFont fontWithName:@"Pricedown" size:25];
//    CGSize expectedLabelSize = [labelTitre.text sizeWithFont:labelTitre.font
//                                           constrainedToSize:CGSizeMake(200, 40)
//                                               lineBreakMode:labelTitre.lineBreakMode];
//    labelTitre.frame = CGRectMake(0, 0, expectedLabelSize.width, expectedLabelSize.height);
//    labelTitre.textColor = [UIColor whiteColor];
//    labelTitre.textAlignment = UITextAlignmentCenter;
//    labelTitre.backgroundColor = [UIColor clearColor];
//    labelTitre.layer.shadowColor = [UIColor blackColor].CGColor;
//    labelTitre.layer.shadowOffset = CGSizeMake(0, 1);
//    labelTitre.layer.shadowOpacity = 1;
//    labelTitre.layer.shadowRadius = 2.0;
//    navItem.titleView = labelTitre;
    
    //Ombre sous la navigationBar
//    CAGradientLayer *shadowLayer = [CAGradientLayer layer];
//    shadowLayer.frame = CGRectMake(0, navBar.frame.size.height, self.view.frame.size.width, 17);
//    UIColor *darkColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.5];
//    UIColor *lightColor = [self.view.backgroundColor colorWithAlphaComponent:0.0];
//    shadowLayer.colors = [NSArray arrayWithObjects:darkColor.CGColor,lightColor.CGColor, nil];
//    shadowLayer.startPoint = CGPointMake(0, 0);
//    shadowLayer.endPoint = CGPointMake(0, 1);
//    [self.view.layer addSublayer:shadowLayer];
    
    //Ombre sur le champs de commentaire
//    fond = [CALayer layer];
//    fond.frame = commentaireField.frame;
//    fond.backgroundColor = [UIColor clearColor].CGColor;
//    fond.shadowColor = [UIColor blackColor].CGColor;
//    fond.shadowOffset = CGSizeMake(0, 0);
//    fond.shadowRadius = 5;
//    fond.shadowOpacity = 0.7;
//    fond.shadowPath = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, fond.frame.size.width, fond.frame.size.height)].CGPath;
//    [self.view.layer insertSublayer:fond atIndex:0];
//    commentaireField.clipsToBounds = YES;
    
    int decalageX = 10;
    int decalageY = 10;
    int hauteurField = 30;
    
    CGRect screenRect = [[UIScreen mainScreen] applicationFrame];
    
    // Initialisation du pseudoField
    pseudoField = [[UITextField alloc] initWithFrame:CGRectMake(decalageX, decalageY, screenRect.size.width - 2*decalageX, hauteurField)];
    pseudoField.borderStyle = UITextBorderStyleRoundedRect;
    pseudoField.delegate = self;
    [self.view addSubview:pseudoField];
    
    // Initialisation du adresseMailField
    adresseMailField = [[UITextField alloc] initWithFrame:CGRectMake(decalageX, pseudoField.frame.origin.y + pseudoField.frame.size.height + decalageY, screenRect.size.width - 2*decalageX, hauteurField)];
    adresseMailField.borderStyle = UITextBorderStyleRoundedRect;
    adresseMailField.delegate = self;
    [self.view addSubview:adresseMailField];
    
    // Initialisation du boutonEnvoyer
    boutonEnvoyer = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    boutonEnvoyer.frame = CGRectMake(decalageX, screenRect.size.height - self.navigationController.navigationBar.frame.size.height - decalageY - hauteurField, screenRect.size.width - 2*decalageX, hauteurField);
    [boutonEnvoyer addTarget:self action:@selector(boutonEnvoyerPushed:) forControlEvents:UIControlEventTouchUpInside];
    [boutonEnvoyer setTitle:@"Commenter" forState:UIControlStateNormal];
    [self.view addSubview:boutonEnvoyer];
    
    // Initialisation du commentaireField
    NSLog(@"%f",screenRect.size.height);
    commentaireField = [[UITextView alloc] initWithFrame:
                        CGRectMake(decalageX,
                                   adresseMailField.frame.origin.y + adresseMailField.frame.size.height + decalageY,
                                   screenRect.size.width - 2*decalageX,
                                   screenRect.size.height - self.navigationController.navigationBar.frame.size.height - pseudoField.frame.size.height - adresseMailField.frame.size.height - boutonEnvoyer.frame.size.height - 5*decalageY)];
    commentaireField.backgroundColor = [UIColor redColor];
    commentaireField.delegate = self;
    [self.view addSubview:commentaireField];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    NSUserDefaults *infoCommentaire = [NSUserDefaults standardUserDefaults];
    pseudoString = [infoCommentaire stringForKey:@"pseudo"];
    adresseMailString = [infoCommentaire stringForKey:@"adresseMail"];
    commentaireString = [infoCommentaire stringForKey:@"commentaire"];
    
    pseudoField.text = [infoCommentaire stringForKey:@"pseudo"];
    adresseMailField.text = [infoCommentaire stringForKey:@"adresseMail"];
    commentaireField.text = [infoCommentaire stringForKey:@"commentaire"];
    NSLog(@"all field fullfiled");
}

-(void)boutonEnvoyerPushed:(id)sender
{
    //Test de l'adresse e-mail valide
    NSString *emailRegEx =
    @"(?:[a-z0-9!#$%\\&'*+/=?\\^_`{|}~-]+(?:\\.[a-z0-9!#$%\\&'*+/=?\\^_`{|}"
    @"~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\"
    @"x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[a-z0-9](?:[a-"
    @"z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\\[(?:(?:25[0-5"
    @"]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-"
    @"9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21"
    @"-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])";
    
    NSPredicate *regExPredicate =
    [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegEx];
    BOOL adresseMailIsValid = [regExPredicate evaluateWithObject:adresseMailString];
    
    NSLog(@"On envoie à \"%@\" (%@) ce message : \"%@\"", pseudoString, adresseMailString, commentaireString);
    
    if ([pseudoString isEqualToString:@""] || [adresseMailString isEqualToString:@""])
    {
        UIAlertView *alertInfoVide = [[UIAlertView alloc] initWithTitle:@"Attention !" message:@"Veuillez renseigner tous les champs" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alertInfoVide show];
    }
    else if ([commentaireString isEqualToString:@""])
    {
        UIAlertView *alertCommentaireVide = [[UIAlertView alloc] initWithTitle:@"Attention !" message:@"Veuillez entrer un commentaire avant de le poster" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alertCommentaireVide show];
    }
    
    else if(!adresseMailIsValid)
    {
        UIAlertView *alertMailNonValide = [[UIAlertView alloc] initWithTitle:@"Attention !" message:@"Votre adresse e-mail n'est pas valide. Vous devez entrer une adresse e-mail valide pour poster un commentaire" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alertMailNonValide show];
    }
    else
    {
        //Envoi du commentaire
        NSString *stringURL = @"http://www.sujetsetcorriges.fr/wp-comments-post.php";
        NSURL *url = [NSURL URLWithString:stringURL];
//        ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
//        
//        [request setPostValue:pseudoString forKey:@"author"];
//        [request setPostValue:adresseMailString forKey:@"email"];
//        [request setPostValue:commentaireString forKey:@"comment"];
//        [request setPostValue:idArticle forKey:@"comment_post_ID"];
//        
//        [request setDelegate:self];
//        [request startAsynchronous];
        
        alertWait = [[UIAlertView alloc] initWithTitle:@"Envoi" message:@"Veuillez patienter quelques secondes..." delegate:self cancelButtonTitle:nil otherButtonTitles:nil];
        [alertWait show];
    }
}

-(void)fermerFenetre:(id)sender
{
    [self dismissModalViewControllerAnimated:YES];
}

-(BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    if (textField == pseudoField)
    {
        pseudoString = pseudoField.text;
        [pseudoField resignFirstResponder];
        
        NSUserDefaults *infoCommentaire = [NSUserDefaults standardUserDefaults];
        [infoCommentaire setObject:pseudoString forKey:@"pseudo"];
        [infoCommentaire synchronize];
        NSLog(@"pseudo saved");
    }
    
    else if (textField == adresseMailField)
    {
        adresseMailString = adresseMailField.text;
        [adresseMailField resignFirstResponder];
        
        NSUserDefaults *infoCommentaire = [NSUserDefaults standardUserDefaults];
        [infoCommentaire setObject:adresseMailString forKey:@"adresseMail"];
        [infoCommentaire synchronize];
        NSLog(@"adresseMail saved");
    }
    
    else
    {
        
    }
    
    return YES;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == pseudoField)
    {
        pseudoString = pseudoField.text;
        [pseudoField resignFirstResponder];
        
        NSUserDefaults *infoCommentaire = [NSUserDefaults standardUserDefaults];
        [infoCommentaire setObject:pseudoString forKey:@"pseudo"];
        [infoCommentaire synchronize];
        NSLog(@"pseudo saved");
    }
    
    else if (textField == adresseMailField)
    {
        adresseMailString = adresseMailField.text;
        [adresseMailField resignFirstResponder];
        
        NSUserDefaults *infoCommentaire = [NSUserDefaults standardUserDefaults];
        [infoCommentaire setObject:adresseMailString forKey:@"adresseMail"];
        [infoCommentaire synchronize];
        NSLog(@"adresseMail saved");
    }
    
    else
    {
        
    }
    
    return YES;
}

-(BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    UIBarButtonItem *commentaireFini = [[UIBarButtonItem alloc] initWithTitle:@"Ok" style:UIBarButtonItemStyleBordered target:self action:@selector(finirCommentaire:)];
    self.navigationItem.rightBarButtonItem = commentaireFini;
    
    [UIView beginAnimations:@"" context:nil];
    [UIView setAnimationDuration:0.2];
    
    commentaireField.frame = CGRectMake(commentaireField.frame.origin.x, commentaireField.frame.origin.y-105, commentaireField.frame.size.width, commentaireField.frame.size.height-30);
    //fond.frame = CGRectMake(fond.frame.origin.x, fond.frame.origin.y-105, fond.frame.size.width, fond.frame.size.height-30);
    //fond.shadowPath = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, fond.frame.size.width, fond.frame.size.height)].CGPath;
    
    [UIView commitAnimations];
    
    return YES;
}

-(BOOL)textViewShouldEndEditing:(UITextView *)textView
{
    commentaireString = commentaireField.text;
    self.navigationItem.rightBarButtonItem = nil;
    
    NSUserDefaults *infoCommentaire = [NSUserDefaults standardUserDefaults];
    [infoCommentaire setObject:commentaireString forKey:@"commentaire"];
    [infoCommentaire synchronize];
    NSLog(@"commentaire saved");
    
    return YES;
}

-(void)finirCommentaire:(id)sender
{
    [self textViewShouldEndEditing:commentaireField];
    [commentaireField resignFirstResponder];
    
    [UIView beginAnimations:@"" context:nil];
    [UIView setAnimationDuration:0.2];
    
    commentaireField.frame = CGRectMake(commentaireField.frame.origin.x, commentaireField.frame.origin.y+105, commentaireField.frame.size.width, commentaireField.frame.size.height+30);
    //fond.frame = CGRectMake(fond.frame.origin.x, fond.frame.origin.y+105, fond.frame.size.width, fond.frame.size.height+30);
    //fond.shadowPath = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, fond.frame.size.width, fond.frame.size.height)].CGPath;
    
    [UIView commitAnimations];
}

@end
