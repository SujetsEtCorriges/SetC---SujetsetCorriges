//
//  ActuDetailViewController.m
//  SetC : SujetsetCorriges
//
//  Created by Mestiri Hedi on 09/09/12.
//  Copyright (c) 2012 Mestiri Hedi. All rights reserved.
//

#import "ActuDetailViewController.h"

@interface ActuDetailViewController ()

@end

@implementation ActuDetailViewController

@synthesize url = _url, webView = _webView, infoView = _infoView, titre = _titre;

/*- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}*/

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"News";
    
   
    
    
    CGFloat hauteurBlocInfo = self.view.frame.size.height - 5*self.view.frame.size.height/6;
    CGFloat hauteurBlocNews = self.view.frame.size.height - self.view.frame.size.height/6;
    
    _infoView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, hauteurBlocInfo)];
    [_infoView setBackgroundColor:[UIColor colorWithHue:0.0 saturation:0.0 brightness:0.9 alpha:1.0]];
    
    titreLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, _infoView.frame.size.width, _infoView.frame.size.height -_infoView.frame.size.height/3)];
    [titreLabel setBackgroundColor:[UIColor clearColor]];
    [titreLabel setTextColor:[UIColor colorWithRed:0.12 green:0.15 blue:0.17 alpha:1.0]];
    [titreLabel setFont:[UIFont fontWithName: @"Arial" size: 17.0f]];
    titreLabel.text = _titre;
    titreLabel.lineBreakMode = UILineBreakModeWordWrap;
    titreLabel.numberOfLines = 2;
    //[titreLabel sizeToFit];

    
    dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 2*_infoView.frame.size.height/3, _infoView.frame.size.width, _infoView.frame.size.height - 2*_infoView.frame.size.height/3)];
    [dateLabel setBackgroundColor:[UIColor clearColor]];
    [dateLabel setTextColor:[UIColor blackColor]];
    [dateLabel setFont:[UIFont fontWithName: @"Arial" size: 12.0f]];
    
    //configuation de la cellule date
    
    //définition des locales pour la date
    NSLocale *frLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"fr_FR"];
    NSLocale *usLocale = [[NSLocale alloc ] initWithLocaleIdentifier:@"en_US_POSIX" ];
    
    //conversion de la date en NSSDate
    NSString *date = _date;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setLocale:usLocale];
    [dateFormatter setDateFormat:@"EEE, dd MMM yyyy HH:mm:ss '+0000'"];
    NSDate *convertedDate = [dateFormatter dateFromString:date];
    [dateFormatter setLocale:frLocale];
    [dateFormatter setDateFormat:@"dd/MM/yyyy"];
    NSString *convertedStringDate = [dateFormatter stringFromDate:convertedDate];
    
    dateLabel.text = convertedStringDate;
    
    
    [_infoView addSubview:titreLabel];
    [_infoView addSubview:dateLabel];
    
    
    _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, hauteurBlocInfo, self.view.frame.size.width, hauteurBlocNews)];
    
    [self.view addSubview:self.webView];
    [self.view addSubview:self.infoView];
    
    UIBarButtonItem *buttonCom = [[UIBarButtonItem alloc] initWithTitle:@"Com's" style:UIBarButtonItemStyleBordered target:self action:@selector(buttonComPushed:)];
    [self.navigationItem setRightBarButtonItem:buttonCom];
}

- (void)viewDidAppear:(BOOL)animated
{
//    self.url = [self.url stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
//    NSURL *newURL = [NSURL URLWithString:[self.url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    //[self.webView loadRequest:[NSURLRequest requestWithURL:newURL]];
    [self.webView loadHTMLString:self.texte baseURL:nil];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)buttonComPushed:(id)sender
{
    CommentsViewController *comVC = [[CommentsViewController alloc]initWithNibName:@"CommentsViewController" bundle:nil];
    [self.navigationController pushViewController:comVC animated:YES];
    
}

@end
