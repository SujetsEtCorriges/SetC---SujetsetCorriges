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

@synthesize url = _url, webView = _webView, infoView = _infoView, titre = _titre, scrollView = _scrollView;

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
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    //définition de hauteurs particulières
    CGFloat hauteurFenetre = self.view.frame.size.height - self.navigationController.navigationBar.frame.size.height - self.tabBarController.tabBar.frame.size.height;
    CGFloat hauteurBlocInfo = hauteurFenetre - round(5*hauteurFenetre/6);
    CGFloat hauteurBlocNews = hauteurFenetre - hauteurBlocInfo;
    
    //définition de la vue info
    _infoView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, hauteurBlocInfo)];
    [_infoView setBackgroundColor:[UIColor colorWithHue:0.0 saturation:0.0 brightness:0.9 alpha:1.0]];
    
    //indication de la proportion en hauteur des cellules titre et date
    CGFloat hauteurBlocTitre = (int)2*_infoView.frame.size.height/3;
    CGFloat hauteurBlocDate = (int)_infoView.frame.size.height/3;
    
    //configuraton de la cellule titre
    titreLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, _infoView.frame.size.width, _infoView.frame.size.height - hauteurBlocDate)];
    [titreLabel setBackgroundColor:[UIColor clearColor]];
    [titreLabel setTextColor:[UIColor colorWithRed:0.12 green:0.15 blue:0.17 alpha:1.0]];
    [titreLabel setFont:[UIFont fontWithName: @"Arial" size: 17.0f]];
    titreLabel.text = _titre;
    titreLabel.lineBreakMode = UILineBreakModeWordWrap;
    titreLabel.numberOfLines = 2;

    
    //configuation de la cellule date
    dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, hauteurBlocTitre, _infoView.frame.size.width, _infoView.frame.size.height - hauteurBlocTitre)];
    [dateLabel setBackgroundColor:[UIColor clearColor]];
    [dateLabel setTextColor:[UIColor blackColor]];
    [dateLabel setFont:[UIFont fontWithName: @"Arial" size: 12.0f]];
    
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
    
    //ajout des labels sur la vue info
    [_infoView addSubview:titreLabel];
    [_infoView addSubview:dateLabel];
    
    //configuration de la scrollview
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, hauteurFenetre)];
     [_scrollView setScrollEnabled:YES];
    [self.view addSubview:_scrollView];
    
    //configuration de la webview
    _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, hauteurBlocInfo, self.view.frame.size.width, hauteurBlocNews)];
    [_webView.scrollView setScrollEnabled:NO];
    [_webView setDelegate:self];
    [_webView loadHTMLString:[NSString stringWithFormat:@"<html> \n"
                                      "<head> \n"
                                      "<style type=\"text/css\"> \n"
                                      "body {color:black; font-family: \"%@\"; font-size: %@; text-shadow: none 0px 1px 0px;}\n"
                                      "img {max-width: 298px; height:auto; margin-left:auto; margin-right:auto; display:block;}\n"
                                      "iframe {max-width: 298px; height:auto; margin-left:auto; margin-right:auto; display:block;}\n"
                                      //"a {color:#337D12; text-decoration: none;}"
                                      "</style> \n"
                                      "</head> \n"
                                      "<body>%@<br></body> \n"
                                      "</html>", @"helvetica", [NSNumber numberWithInt:13],self.texte] baseURL:nil];
    
    //ajout des éléments sur la scrollview
    [_scrollView addSubview:self.webView];
    [_scrollView addSubview:self.infoView];
    
    //ajout du bouton "commentaires"
    UIBarButtonItem *buttonCom = [[UIBarButtonItem alloc] initWithTitle:@"Com's" style:UIBarButtonItemStyleBordered target:self action:@selector(buttonComPushed:)];
    [self.navigationItem setRightBarButtonItem:buttonCom];
}

- (void)viewDidAppear:(BOOL)animated
{
//    self.url = [self.url stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
//    NSURL *newURL = [NSURL URLWithString:[self.url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    //[self.webView loadRequest:[NSURLRequest requestWithURL:newURL]];
    //[self.webView loadHTMLString:self.texte baseURL:nil];
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

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    [_webView sizeToFit];
    
    //Redimensionnement de la scrollview
    NSString *heightString = [webView stringByEvaluatingJavaScriptFromString:@"document.body.offsetHeight;"];
    CGFloat height = [heightString floatValue] + 16;
    NSLog(@"%f",height);
    CGRect frame = _webView.frame;
    frame.size.height = height;
    _webView.frame = frame;
    
    [_scrollView setContentSize: CGSizeMake(_scrollView.frame.size.width, height + _webView.frame.origin.y)];
}

- (void)buttonComPushed:(id)sender
{
    CommentsViewController *comVC = [[CommentsViewController alloc]initWithNibName:@"CommentsViewController" bundle:nil];
    [self.navigationController pushViewController:comVC animated:YES];
    
}

@end
