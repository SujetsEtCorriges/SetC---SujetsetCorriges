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

@synthesize url = url_;
@synthesize webView = webView_;
@synthesize infoView = infoView_;
@synthesize titre = titre_;
@synthesize idArticle = idArticle_;

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
    CGRect screenRect = [[UIScreen mainScreen] applicationFrame];
    CGFloat hauteurFenetre = screenRect.size.height - self.navigationController.navigationBar.frame.size.height - self.tabBarController.tabBar.frame.size.height;
    CGFloat hauteurBlocInfo = hauteurFenetre - round(5*hauteurFenetre/6);
    CGFloat hauteurBlocNews = hauteurFenetre - hauteurBlocInfo;
    
    //définition de la vue info
    infoView_ = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, hauteurBlocInfo)];
    [infoView_ setBackgroundColor:[UIColor colorWithHue:0.0 saturation:0.0 brightness:0.9 alpha:1.0]];
    
    //indication de la proportion en hauteur des cellules titre et date
    CGFloat hauteurBlocTitre = (int)2*infoView_.frame.size.height/3;
    CGFloat hauteurBlocDate = (int)infoView_.frame.size.height/3;
    
    //configuraton de la cellule titre
    titreLabel_ = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, infoView_.frame.size.width, infoView_.frame.size.height - hauteurBlocDate)];
    [titreLabel_ setBackgroundColor:[UIColor clearColor]];
    [titreLabel_ setTextColor:[UIColor colorWithRed:0.12 green:0.15 blue:0.17 alpha:1.0]];
    [titreLabel_ setFont:[UIFont fontWithName: @"Arial" size: 17.0f]];
    titreLabel_.text = titre_;
    titreLabel_.lineBreakMode = UILineBreakModeWordWrap;
    titreLabel_.numberOfLines = 2;
    
    
    //configuation de la cellule date
    dateLabel_ = [[UILabel alloc] initWithFrame:CGRectMake(15, hauteurBlocTitre, infoView_.frame.size.width, infoView_.frame.size.height - hauteurBlocTitre)];
    [dateLabel_ setBackgroundColor:[UIColor clearColor]];
    [dateLabel_ setTextColor:[UIColor blackColor]];
    [dateLabel_ setFont:[UIFont fontWithName: @"Arial" size: 12.0f]];
    
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
    
    dateLabel_.text = convertedStringDate;
    
    //ajout des labels sur la vue info
    [infoView_ addSubview:titreLabel_];
    [infoView_ addSubview:dateLabel_];
    
    //configuration de la scrollview
    scrollView_ = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, hauteurFenetre)];
    [scrollView_ setScrollEnabled:YES];
    [self.view addSubview:scrollView_];
    
    //configuration de la webview
    webView_ = [[UIWebView alloc] initWithFrame:CGRectMake(0, hauteurBlocInfo, self.view.frame.size.width, hauteurBlocNews)];
    [webView_.scrollView setScrollEnabled:NO];
    [webView_ setDelegate:self];
    [webView_ loadHTMLString:[NSString stringWithFormat:@"<html> \n"
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
    [scrollView_ addSubview:self.webView];
    [scrollView_ addSubview:self.infoView];
    
    //ajout du bouton "commentaires"
    /*UIBarButtonItem *buttonCom = [[UIBarButtonItem alloc] initWithTitle:@"Com's" style:UIBarButtonItemStyleBordered target:self action:@selector(buttonComPushed:)];
    [self.navigationItem setRightBarButtonItem:buttonCom];*/
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Right"
                                                                             style:UIBarButtonItemStyleBordered
                                                                            target:self
                                                                            action:@selector(showRight:)];
}

- (void)viewDidAppear:(BOOL)animated
{

}

- (void)viewDidUnload
{
    [super viewDidUnload];
}


- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    PartageViewController *partageView = [[PartageViewController alloc] initWithNibName:@"PartageViewController" bundle:nil];
    partageView.urlComments = url_;
    partageView.idArticle = idArticle_;
    [self.revealSideViewController preloadViewController:partageView forSide:PPRevealSideDirectionRight];
}

- (void) showRight:(id)sender
{    
    [self.revealSideViewController pushOldViewControllerOnDirection:PPRevealSideDirectionRight withOffset:260 animated:YES];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    [webView_ sizeToFit];
    
    //Redimensionnement de la scrollview
    NSString *heightString = [webView stringByEvaluatingJavaScriptFromString:@"document.body.offsetHeight;"];
    CGFloat height = [heightString floatValue] + 16;
    NSLog(@"%f",height);
    CGRect frame = webView_.frame;
    frame.size.height = height;
    webView_.frame = frame;
    
    [scrollView_ setContentSize: CGSizeMake(scrollView_.frame.size.width, height + webView_.frame.origin.y)];
}

//- (void)buttonComPushed:(id)sender
//{
//    CommentsViewController *comVC = [[CommentsViewController alloc]initWithNibName:@"CommentsViewController" bundle:nil];
//    comVC.url = [NSString stringWithFormat:@"%@feed",url_];
//    NSLog(@"idArticle : %@",idArticle_);
//    comVC.idArticle = idArticle_;
//    [self.navigationController pushViewController:comVC animated:YES];
//}

@end