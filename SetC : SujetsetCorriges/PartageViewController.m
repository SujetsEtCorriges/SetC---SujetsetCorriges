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

@synthesize urlComments = _urlComments;

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
    
    _boutonCom = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [_boutonCom addTarget:self
               action:@selector(boutonComPushed:)
        forControlEvents:UIControlEventTouchDown];
    [_boutonCom setTitle:@"Com's" forState:UIControlStateNormal];
    _boutonCom.frame = CGRectMake(260, 80, 60, height);
    [self.view addSubview:_boutonCom];
    
    _boutonFacebook = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [_boutonFacebook addTarget:self
                  action:@selector(boutonFacebookPushed:)
        forControlEvents:UIControlEventTouchDown];
    [_boutonFacebook setTitle:@"Facebook" forState:UIControlStateNormal];
    _boutonFacebook.frame = CGRectMake(260, _boutonCom.frame.origin.y + height + ecart, 60, height);
    [self.view addSubview:_boutonFacebook];
    
    _boutonTwitter = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [_boutonTwitter addTarget:self
                       action:@selector(boutonTwitterPushed:)
             forControlEvents:UIControlEventTouchDown];
    [_boutonTwitter setTitle:@"Twitter" forState:UIControlStateNormal];
    _boutonTwitter.frame = CGRectMake(260, _boutonFacebook.frame.origin.y + height + ecart, 60, height);
    [self.view addSubview:_boutonTwitter];
    
    _boutonMail = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [_boutonMail addTarget:self
                      action:@selector(boutonMailPushed:)
            forControlEvents:UIControlEventTouchDown];
    [_boutonMail setTitle:@"Mail" forState:UIControlStateNormal];
    _boutonMail.frame = CGRectMake(260, _boutonTwitter.frame.origin.y + height + ecart, 60, height);
    [self.view addSubview:_boutonMail];
    
    _boutonSafari = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [_boutonSafari addTarget:self
                      action:@selector(boutonTwitterPushed:)
            forControlEvents:UIControlEventTouchDown];
    [_boutonSafari setTitle:@"Safari" forState:UIControlStateNormal];
    _boutonSafari.frame = CGRectMake(260, _boutonMail.frame.origin.y + height + ecart, 60, height);
    [self.view addSubview:_boutonSafari];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)boutonComPushed:(id)sender
{
    [self.revealSideViewController popViewControllerAnimated:YES];
    
//    CommentsViewController *comVC = [[CommentsViewController alloc]initWithNibName:@"CommentsViewController" bundle:nil];
//    NSString *_url = @"";
//    comVC.url = [NSString stringWithFormat:@"%@feed",_url];
//    [self.navigationController pushViewController:comVC animated:YES];
    
    CommentsViewController *comVC = [[CommentsViewController alloc]initWithNibName:@"CommentsViewController" bundle:nil];
    comVC.url = [NSString stringWithFormat:@"%@feed",_urlComments];
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
