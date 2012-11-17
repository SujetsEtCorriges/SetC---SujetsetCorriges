//
//  PartageViewController.m
//  SetC : SujetsetCorriges
//
//  Created by Jérémy on 02/10/12.
//  Copyright (c) 2012 Mestiri Hedi. All rights reserved.
//

#import "PartageViewController.h"
#import <Twitter/Twitter.h>
#import <Social/Social.h>

@interface PartageViewController ()

@end

@implementation PartageViewController

@synthesize urlComments = urlComments_;
@synthesize idArticle = idArticle_;
@synthesize titreArticle = titreArticle_;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.view.backgroundColor = [UIColor colorWithWhite:0.15 alpha:1];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    CGFloat height = 50;
    CGFloat ecart = 15;
    
    boutonCom_ = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [boutonCom_ addTarget:self
               action:@selector(boutonComPushed:)
        forControlEvents:UIControlEventTouchDown];
    [boutonCom_ setTitle:@"Com's" forState:UIControlStateNormal];
    boutonCom_.frame = CGRectMake(260, 80, 60, height);
    [self.view addSubview:boutonCom_];
    
    boutonFacebook_ = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [boutonFacebook_ addTarget:self
                  action:@selector(boutonFacebookPushed:)
        forControlEvents:UIControlEventTouchDown];
    [boutonFacebook_ setTitle:@"Facebook" forState:UIControlStateNormal];
    boutonFacebook_.frame = CGRectMake(260, boutonCom_.frame.origin.y + height + ecart, 60, height);
    [self.view addSubview:boutonFacebook_];
    
    boutonTwitter_ = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [boutonTwitter_ addTarget:self
                       action:@selector(boutonTwitterPushed:)
             forControlEvents:UIControlEventTouchDown];
    [boutonTwitter_ setTitle:@"Twitter" forState:UIControlStateNormal];
    boutonTwitter_.frame = CGRectMake(260, boutonFacebook_.frame.origin.y + height + ecart, 60, height);
    [self.view addSubview:boutonTwitter_];
    
    boutonMail_ = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [boutonMail_ addTarget:self
                      action:@selector(boutonMailPushed:)
            forControlEvents:UIControlEventTouchDown];
    [boutonMail_ setTitle:@"Mail" forState:UIControlStateNormal];
    boutonMail_.frame = CGRectMake(260, boutonTwitter_.frame.origin.y + height + ecart, 60, height);
    [self.view addSubview:boutonMail_];
    
    boutonSafari_ = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [boutonSafari_ addTarget:self
                      action:@selector(boutonTwitterPushed:)
            forControlEvents:UIControlEventTouchDown];
    [boutonSafari_ setTitle:@"Safari" forState:UIControlStateNormal];
    boutonSafari_.frame = CGRectMake(260, boutonMail_.frame.origin.y + height + ecart, 60, height);
    [self.view addSubview:boutonSafari_];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)boutonComPushed:(id)sender
{
    [self.revealSideViewController popViewControllerAnimated:YES];
    
    CommentsViewController *comVC = [[CommentsViewController alloc]initWithNibName:@"CommentsViewController" bundle:nil];
    comVC.url = [NSString stringWithFormat:@"%@feed",urlComments_];
    comVC.idArticle = idArticle_;
    UINavigationController *n = [[UINavigationController alloc] initWithRootViewController:comVC];
    
    [self presentModalViewController:n animated:YES];
}

-(void)boutonFacebookPushed:(id)sender
{
    SLComposeViewController *facebook = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
    [facebook addImage:[UIImage imageNamed:@"Icone117.png"]];
    [facebook addURL:[NSURL URLWithString:urlComments_]];
    [facebook setInitialText:titreArticle_];
    [self presentModalViewController:facebook animated:YES];
    
    facebook.completionHandler = ^(SLComposeViewControllerResult result)
    {
        NSString *title = @"Partage Facebook";
        NSString *msg;
        
        if (result == SLComposeViewControllerResultCancelled)
            msg = @"Annulation du partage sur Facebook";
        else if (result == SLComposeViewControllerResultDone)
            msg = @"L'article a été partagé sur Facebook";
        
        // Show alert to see how things went...
        UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:title message:msg delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alertView show];
        
        // Dismiss the controller
        [self dismissModalViewControllerAnimated:YES];
    };
}

-(void)boutonTwitterPushed:(id)sender
{
    TWTweetComposeViewController *twitter = [[TWTweetComposeViewController alloc] init];
    [twitter addImage:[UIImage imageNamed:@"Icone117.png"]];
    [twitter addURL:[NSURL URLWithString:urlComments_]];
    [twitter setInitialText:titreArticle_];
    [self presentModalViewController:twitter animated:YES];
    
    // Called when the tweet dialog has been closed
    twitter.completionHandler = ^(TWTweetComposeViewControllerResult result)
    {
        NSString *title = @"Partage Twitter";
        NSString *msg;
        
        if (result == TWTweetComposeViewControllerResultCancelled)
            msg = @"L'envoi du tweet a été annulé";
        else if (result == TWTweetComposeViewControllerResultDone)
            msg = @"Tweet envoyé";
        
        // Show alert to see how things went...
        UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:title message:msg delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alertView show];
        
        // Dismiss the controller
        [self dismissModalViewControllerAnimated:YES];
    };

    
}

-(void)boutonMailPushed:(id)sender
{
    
}

-(void)boutonSafariPushed:(id)sender
{
    
}

@end
