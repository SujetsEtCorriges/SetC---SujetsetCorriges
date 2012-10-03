//
//  PartageViewController.m
//  SetC : SujetsetCorriges
//
//  Created by Jérémy on 02/10/12.
//  Copyright (c) 2012 Mestiri Hedi. All rights reserved.
//

#import "PartageViewController.h"

@interface PartageViewController ()

@end

@implementation PartageViewController

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
    
    boutonCom = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [boutonCom addTarget:self
               action:@selector(boutonComPushed:)
        forControlEvents:UIControlEventTouchDown];
    [boutonCom setTitle:@"Com's" forState:UIControlStateNormal];
    boutonCom.frame = CGRectMake(260, 80, 60, height);
    [self.view addSubview:boutonCom];
    
    boutonFacebook = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [boutonFacebook addTarget:self
                  action:@selector(boutonFacebookPushed:)
        forControlEvents:UIControlEventTouchDown];
    [boutonFacebook setTitle:@"Facebook" forState:UIControlStateNormal];
    boutonFacebook.frame = CGRectMake(260, boutonCom.frame.origin.y + height + ecart, 60, height);
    [self.view addSubview:boutonFacebook];
    
    boutonTwitter = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [boutonTwitter addTarget:self
                       action:@selector(boutonTwitterPushed:)
             forControlEvents:UIControlEventTouchDown];
    [boutonTwitter setTitle:@"Twitter" forState:UIControlStateNormal];
    boutonTwitter.frame = CGRectMake(260, boutonFacebook.frame.origin.y + height + ecart, 60, height);
    [self.view addSubview:boutonTwitter];
    
    boutonMail = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [boutonMail addTarget:self
                      action:@selector(boutonMailPushed:)
            forControlEvents:UIControlEventTouchDown];
    [boutonMail setTitle:@"Mail" forState:UIControlStateNormal];
    boutonMail.frame = CGRectMake(260, boutonTwitter.frame.origin.y + height + ecart, 60, height);
    [self.view addSubview:boutonMail];
    
    boutonSafari = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [boutonSafari addTarget:self
                      action:@selector(boutonTwitterPushed:)
            forControlEvents:UIControlEventTouchDown];
    [boutonSafari setTitle:@"Safari" forState:UIControlStateNormal];
    boutonSafari.frame = CGRectMake(260, boutonMail.frame.origin.y + height + ecart, 60, height);
    [self.view addSubview:boutonSafari];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)boutonComPushed:(id)sender
{
    CommentsViewController *comVC = [[CommentsViewController alloc] initWithNibName:@"CommentsViewController" bundle:nil];
    NSString *_url = @"";
    comVC.url = [NSString stringWithFormat:@"%@feed",_url];
    
    UINavigationController *n = [[UINavigationController alloc] initWithRootViewController:comVC];
   
    //[self.navigationController presentModalViewController:n animated:YES];
    //[self.revealSideViewController presentModalViewController:n animated:YES];
    [self.revealSideViewController popViewControllerWithNewCenterController:n animated:YES];
}

-(void)boutonFacebookPushed:(id)sender
{
    
}

-(void)boutonTwitterPushed:(id)sender
{
    
}

-(void)boutonMailPushed:(id)sender
{
    
}

-(void)boutonSafariPushed:(id)sender
{
    
}

@end
