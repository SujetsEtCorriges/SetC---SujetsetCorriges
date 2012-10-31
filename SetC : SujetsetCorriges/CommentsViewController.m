//
//  CommentsViewController.m
//  SetC : SujetsetCorriges
//
//  Created by Jérémy on 23/09/12.
//  Copyright (c) 2012 Mestiri Hedi. All rights reserved.
//

#import "CommentsViewController.h"

@interface CommentsViewController ()

@end

@implementation CommentsViewController
{
    PullToRefreshView *pull;
}
@synthesize url = url_;
@synthesize idArticle = idArticle_;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"Commentaires";
    
    //Bouton de fermeture
    UIBarButtonItem *boutonFermer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemStop target:self action:@selector(fermerView:)];
    self.navigationItem.leftBarButtonItem = boutonFermer;
    
    //Bouton de redaction
    UIBarButtonItem *boutonRediger = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCompose target:self action:@selector(redigerComment:)];
    self.navigationItem.rightBarButtonItem = boutonRediger;
    
    //calcul de la hauteur de la fenetre
    CGRect screenRect = [[UIScreen mainScreen] applicationFrame];
    CGFloat hauteurFenetre = screenRect.size.height - self.navigationController.navigationBar.frame.size.height - self.tabBarController.tabBar.frame.size.height;
    
    //initialisation de la tableview
    commentsTableView_ = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, hauteurFenetre) style:UITableViewStylePlain];
    [commentsTableView_ setDelegate:self];
    [commentsTableView_ setDataSource:self];
    [self.view addSubview:commentsTableView_];
    
    //notification de rafraichissement
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(foregroundRefresh:)
                                                 name:UIApplicationWillEnterForegroundNotification
                                               object:nil];
    
    //initialisation de la vue pull to refresh
    pull = [[PullToRefreshView alloc] initWithScrollView:(UIScrollView *) commentsTableView_];
    [pull setDelegate:self];
    [commentsTableView_ addSubview:pull];
    
    //parsage des commentaires
    parser_ = [[XMLParser alloc] init];
    parser_.delegate = self;
    [self performSelectorInBackground:@selector(parseComments:) withObject:url_];
}

- (void) parseComments:(NSString*)theURL
{
    @autoreleasepool
    {
        commentsTableView_.separatorStyle = UITableViewCellSeparatorStyleNone;
        MBProgressHUD *chargementHUD = [MBProgressHUD showHUDAddedTo:commentsTableView_ animated:YES];
        [chargementHUD setLabelText:@"Chargement"];
        [parser_ parseXMLFileAtURL:theURL];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [commentsData_ count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *message = [[commentsData_ objectAtIndex:indexPath.row] objectForKey:@"message"];
    
    int decalageTexteX = 20;
    
    CGSize constraint = CGSizeMake(self.view.frame.size.width-2*decalageTexteX, 2000000.0f);
    
    CGSize size = [message sizeWithFont:[UIFont systemFontOfSize:12.0] constrainedToSize:constraint lineBreakMode:UILineBreakModeWordWrap];
    
    CGFloat height = MAX(size.height, 50.0f);
    
    return height + 30;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CommentCell";
    
    CommentCell *cell = (CommentCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[CommentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    
    //configuration du titre de la cellule
    cell.pseudoLabel.text = [[commentsData_ objectAtIndex:indexPath.row] objectForKey:@"title"];
    cell.pseudoLabel.numberOfLines = 2;
    
    //configuration du message de la cellule
    NSString *message = [[commentsData_ objectAtIndex:indexPath.row] objectForKey:@"message"];
    int decalageTexteX = 20;
    int decalageTexteY = 20;
    CGSize constraint = CGSizeMake(cell.frame.size.width-2*decalageTexteX, 2000000.0f);
    CGSize size = [message sizeWithFont:[UIFont systemFontOfSize:12.0] constrainedToSize:constraint lineBreakMode:UILineBreakModeWordWrap];
    CGFloat height = MAX(size.height, 50.0f);
    
    cell.messageLabel.lineBreakMode = UILineBreakModeWordWrap;
    cell.messageLabel.numberOfLines = 0;
    cell.messageLabel.font = [UIFont systemFontOfSize:12];
    cell.messageLabel.frame = CGRectMake(decalageTexteX, decalageTexteY, constraint.width, height);
    cell.messageLabel.text = message;
    
    //configuation de la cellule date
    //définition des locales pour la date
    NSLocale *frLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"fr_FR"];
    NSLocale *usLocale = [[NSLocale alloc ] initWithLocaleIdentifier:@"en_US_POSIX" ];
    
    //conversion de la date en NSSDate
    NSString *date = [[commentsData_ objectAtIndex:indexPath.row] objectForKey:@"date"];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setLocale:usLocale];
    [dateFormatter setDateFormat:@"EEE, dd MMM yyyy HH:mm:ss '+0000'"];
    NSDate *convertedDate = [dateFormatter dateFromString:date];
    [dateFormatter setLocale:frLocale];
    [dateFormatter setDateFormat:@"dd/MM"];
    NSString *convertedStringDate = [dateFormatter stringFromDate:convertedDate];
    
    cell.dateLabel.text = convertedStringDate;
    
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    //renvoi de la cellule
    return cell;
}

-(void) fermerView:(id)sender
{
    [self dismissModalViewControllerAnimated:YES];
}

-(void) redigerComment:(id)sender
{
    RedactionCommentViewController *redacComVC = [[RedactionCommentViewController alloc] initWithNibName:@"RedactionCommentViewController" bundle:nil];
    redacComVC.idArticle = idArticle_;
    [self.navigationController pushViewController:redacComVC animated:YES];
}

#pragma mark - Table view delegate

//méthode pour le pull to refresh
- (void)pullToRefreshViewShouldRefresh:(PullToRefreshView *)view;
{
    [self performSelectorInBackground:@selector(parseComments:) withObject:url_];
}

-(void)foregroundRefresh:(NSNotification *)notification
{
    commentsTableView_.contentOffset = CGPointMake(0, -65);
    [pull setState:PullToRefreshViewStateLoading];
    [self performSelectorInBackground:@selector(parseComments:) withObject:url_];
}

#pragma mark - XMLParserDelegate
- (void) xmlParser:(XMLParser *)parser didFinishParsing:(NSArray *)array
{
    commentsData_ = parser_.XMLData;
    [commentsTableView_ reloadData];
    commentsTableView_.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [pull finishedLoading];
    [MBProgressHUD hideHUDForView:commentsTableView_ animated:YES];
}

- (void) xmlParser:(XMLParser *)parser didFailWithError:(NSArray *)error
{
    
}



@end
