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

@synthesize idArticle = idArticle_;

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
    pseudoField_ = [[UITextField alloc] initWithFrame:CGRectMake(decalageX, decalageY, screenRect.size.width - 2*decalageX, hauteurField)];
    pseudoField_.borderStyle = UITextBorderStyleRoundedRect;
    pseudoField_.delegate = self;
    [self.view addSubview:pseudoField_];
    
    // Initialisation du adresseMailField
    adresseMailField_ = [[UITextField alloc] initWithFrame:CGRectMake(decalageX, pseudoField_.frame.origin.y + pseudoField_.frame.size.height + decalageY, screenRect.size.width - 2*decalageX, hauteurField)];
    adresseMailField_.borderStyle = UITextBorderStyleRoundedRect;
    adresseMailField_.delegate = self;
    [self.view addSubview:adresseMailField_];
    
    // Initialisation du boutonEnvoyer
    boutonEnvoyer_ = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    boutonEnvoyer_.frame = CGRectMake(decalageX, screenRect.size.height - self.navigationController.navigationBar.frame.size.height - decalageY - hauteurField, screenRect.size.width - 2*decalageX, hauteurField);
    [boutonEnvoyer_ addTarget:self action:@selector(boutonEnvoyerPushed:) forControlEvents:UIControlEventTouchUpInside];
    [boutonEnvoyer_ setTitle:@"Commenter" forState:UIControlStateNormal];
    [self.view addSubview:boutonEnvoyer_];
    
    // Initialisation du commentaireField
    NSLog(@"%f",screenRect.size.height);
    commentaireField_ = [[UITextView alloc] initWithFrame:
                        CGRectMake(decalageX,
                                   adresseMailField_.frame.origin.y + adresseMailField_.frame.size.height + decalageY,
                                   screenRect.size.width - 2*decalageX,
                                   screenRect.size.height - self.navigationController.navigationBar.frame.size.height - pseudoField_.frame.size.height - adresseMailField_.frame.size.height - boutonEnvoyer_.frame.size.height - 5*decalageY)];
    commentaireField_.backgroundColor = [UIColor redColor];
    commentaireField_.delegate = self;
    [self.view addSubview:commentaireField_];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    NSUserDefaults *infoCommentaire = [NSUserDefaults standardUserDefaults];
    pseudoString_ = [infoCommentaire stringForKey:@"pseudo"];
    adresseMailString_ = [infoCommentaire stringForKey:@"adresseMail"];
    commentaireString_ = [infoCommentaire stringForKey:@"commentaire"];
    
    pseudoField_.text = [infoCommentaire stringForKey:@"pseudo"];
    adresseMailField_.text = [infoCommentaire stringForKey:@"adresseMail"];
    commentaireField_.text = [infoCommentaire stringForKey:@"commentaire"];
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
    
    NSPredicate *regExPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegEx];
    BOOL adresseMailIsValid = [regExPredicate evaluateWithObject:adresseMailString_];
    
    NSLog(@"On envoie à \"%@\" (%@) ce message : \"%@\"", pseudoString_, adresseMailString_, commentaireString_);
    
    if ([pseudoString_ isEqualToString:@""] || [adresseMailString_ isEqualToString:@""])
    {
        UIAlertView *alertInfoVide = [[UIAlertView alloc] initWithTitle:@"Attention !" message:@"Veuillez renseigner tous les champs" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alertInfoVide show];
    }
    else if ([commentaireString_ isEqualToString:@""])
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
        ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
        
        [request setPostValue:pseudoString_ forKey:@"author"];
        [request setPostValue:adresseMailString_ forKey:@"email"];
        [request setPostValue:commentaireString_ forKey:@"comment"];
        [request setPostValue:idArticle_ forKey:@"comment_post_ID"];
        
        [request setDelegate:self];
        [request startAsynchronous];
        
        alertWait_ = [[UIAlertView alloc] initWithTitle:@"Envoi" message:@"Veuillez patienter quelques secondes..." delegate:self cancelButtonTitle:nil otherButtonTitles:nil];
        [alertWait_ show];
    }
}

- (void)requestFinished:(ASIHTTPRequest *)request
{
    [alertWait_ dismissWithClickedButtonIndex:0 animated:YES];
    
    alertMessageSend_ = [[UIAlertView alloc] initWithTitle:@"" message:@"Votre commentaire a bien été posté" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
    [alertMessageSend_ show];
    
    NSUserDefaults *infoCommentaire = [NSUserDefaults standardUserDefaults];
    [infoCommentaire setObject:@"" forKey:@"commentaire"];
    [infoCommentaire synchronize];
}

- (void)requestFailed:(ASIHTTPRequest *)request
{
    //NSError *error = [request error];
    NSLog(@"error!");
    
    [alertWait_ dismissWithClickedButtonIndex:0 animated:YES];
    
    UIAlertView *alertError = [[UIAlertView alloc] initWithTitle:@"Erreur" message:@"Votre commentaire n'a pas été posté ! Vérifiez votre connexion internet puis réessayez" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
    [alertError show];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSLog(@"Une alertView a été cancelled");
    if(alertView == alertMessageSend_)
    {
        NSLog(@"alerteMessageSend cancelled");
        [self dismissModalViewControllerAnimated:YES];
    }
}


-(void)fermerFenetre:(id)sender
{
    [self dismissModalViewControllerAnimated:YES];
}

-(BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    if (textField == pseudoField_)
    {
        pseudoString_ = pseudoField_.text;
        [pseudoField_ resignFirstResponder];
        
        NSUserDefaults *infoCommentaire = [NSUserDefaults standardUserDefaults];
        [infoCommentaire setObject:pseudoString_ forKey:@"pseudo"];
        [infoCommentaire synchronize];
        NSLog(@"pseudo saved");
    }
    
    else if (textField == adresseMailField_)
    {
        adresseMailString_ = adresseMailField_.text;
        [adresseMailField_ resignFirstResponder];
        
        NSUserDefaults *infoCommentaire = [NSUserDefaults standardUserDefaults];
        [infoCommentaire setObject:adresseMailString_ forKey:@"adresseMail"];
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
    if (textField == pseudoField_)
    {
        pseudoString_ = pseudoField_.text;
        [pseudoField_ resignFirstResponder];
        
        NSUserDefaults *infoCommentaire = [NSUserDefaults standardUserDefaults];
        [infoCommentaire setObject:pseudoString_ forKey:@"pseudo"];
        [infoCommentaire synchronize];
        NSLog(@"pseudo saved");
    }
    
    else if (textField == adresseMailField_)
    {
        adresseMailString_ = adresseMailField_.text;
        [adresseMailField_ resignFirstResponder];
        
        NSUserDefaults *infoCommentaire = [NSUserDefaults standardUserDefaults];
        [infoCommentaire setObject:adresseMailString_ forKey:@"adresseMail"];
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
    
    commentaireField_.frame = CGRectMake(commentaireField_.frame.origin.x, commentaireField_.frame.origin.y-80, commentaireField_.frame.size.width, commentaireField_.frame.size.height-95);
    //fond.frame = CGRectMake(fond.frame.origin.x, fond.frame.origin.y-105, fond.frame.size.width, fond.frame.size.height-30);
    //fond.shadowPath = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, fond.frame.size.width, fond.frame.size.height)].CGPath;
    
    [UIView commitAnimations];
    
    return YES;
}

-(BOOL)textViewShouldEndEditing:(UITextView *)textView
{
    commentaireString_ = commentaireField_.text;
    self.navigationItem.rightBarButtonItem = nil;
    
    NSUserDefaults *infoCommentaire = [NSUserDefaults standardUserDefaults];
    [infoCommentaire setObject:commentaireString_ forKey:@"commentaire"];
    [infoCommentaire synchronize];
    NSLog(@"commentaire saved");
    
    return YES;
}

-(void)finirCommentaire:(id)sender
{
    [self textViewShouldEndEditing:commentaireField_];
    [commentaireField_ resignFirstResponder];
    
    [UIView beginAnimations:@"" context:nil];
    [UIView setAnimationDuration:0.2];
    
    commentaireField_.frame = CGRectMake(commentaireField_.frame.origin.x, commentaireField_.frame.origin.y+80, commentaireField_.frame.size.width, commentaireField_.frame.size.height+95);
    //fond.frame = CGRectMake(fond.frame.origin.x, fond.frame.origin.y+105, fond.frame.size.width, fond.frame.size.height+30);
    //fond.shadowPath = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, fond.frame.size.width, fond.frame.size.height)].CGPath;
    
    [UIView commitAnimations];
}

@end
