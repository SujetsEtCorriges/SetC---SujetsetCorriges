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
@synthesize parseResults = _parseResults, url = _url;

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
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"Commentaires";
    
    CGFloat hauteurFenetre = self.view.frame.size.height - self.navigationController.navigationBar.frame.size.height - self.tabBarController.tabBar.frame.size.height;
    
    commentsTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, hauteurFenetre) style:UITableViewStylePlain];
    [commentsTableView setDelegate:self];
    [commentsTableView setDataSource:self];
    [self.view addSubview:commentsTableView];
    
    //notification de rafraichissement
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(foregroundRefresh:)
                                                 name:UIApplicationWillEnterForegroundNotification
                                               object:nil];
    
    //initialisation de la vue pull to refresh
    pull = [[PullToRefreshView alloc] initWithScrollView:(UIScrollView *) commentsTableView];
    [pull setDelegate:self];
    [commentsTableView addSubview:pull];
    
    //parsage des news
    /*KMXMLParser *parser = [[KMXMLParser alloc]  initWithURL:_url delegate:nil]; //possibilite dans le delegate de faire une action, par exemple mettre un truc de chargement
    _parseResults = [parser posts];*/
    
    [self performSelectorInBackground:@selector(parseComments:) withObject:_url];
}

- (void) parseComments:(NSString*)theURL
{
    @autoreleasepool {
        KMXMLParser *parser = [[KMXMLParser alloc] initWithURL:theURL delegate:nil];
        parser.delegate = self;
        if ([_parseResults count] == 0)
        {
            _parseResults = [parser posts];
            [commentsTableView reloadData];
        }
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
    return self.parseResults.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *message = [[self.parseResults objectAtIndex:indexPath.row] objectForKey:@"message"];
    
    //CGSize constraint = CGSizeMake(250, 2000000.0f);
    
    int decalageTexteX = 20;
    //int decalageTexteY = 50;
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
    cell.pseudoLabel.text = [[self.parseResults objectAtIndex:indexPath.row] objectForKey:@"title"];
    cell.pseudoLabel.numberOfLines = 2;
    
    //configuration du message de la cellule
    NSString *message = [[self.parseResults objectAtIndex:indexPath.row] objectForKey:@"message"];
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
    NSString *date = [[self.parseResults objectAtIndex:indexPath.row] objectForKey:@"date"];
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

#pragma mark - Table view delegate

//méthode pour le pull to refresh

- (void)pullToRefreshViewShouldRefresh:(PullToRefreshView *)view;
{
    [self performSelectorInBackground:@selector(reloadTableData) withObject:nil];
}


-(void) reloadTableData
{
    // call to reload your data
    //parsage des news
    KMXMLParser *parser = [[KMXMLParser alloc]  initWithURL:_url delegate:nil]; //possibilite dans le delegate de faire une action, par exemple mettre un truc de chargement
    _parseResults = [parser posts];
    [commentsTableView reloadData];
    [pull finishedLoading];
}

-(void)foregroundRefresh:(NSNotification *)notification
{
    commentsTableView.contentOffset = CGPointMake(0, -65);
    [pull setState:PullToRefreshViewStateLoading];
    [self performSelectorInBackground:@selector(reloadTableData) withObject:nil];
}


@end
