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

@synthesize urlComments = urlComments_, idArticle = idArticle_;

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
