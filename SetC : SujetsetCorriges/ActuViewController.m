//
//  ActuViewController.m
//  SetC : SujetsetCorriges
//
//  Created by Mestiri Hedi on 09/09/12.
//  Copyright (c) 2012 Mestiri Hedi. All rights reserved.
//

#import "ActuViewController.h"
#import "ActuCell.h"


@interface ActuViewController ()

@end

@implementation ActuViewController
{
    PullToRefreshView *pull;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self)
    {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    //notification de rafraichissement
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(foregroundRefresh:)
                                                 name:UIApplicationWillEnterForegroundNotification
                                               object:nil];
    
    //initialisation de la vue pull to refresh
    pull = [[PullToRefreshView alloc] initWithScrollView:(UIScrollView *) self.tableView];
    [pull setDelegate:self];
    [self.tableView addSubview:pull];
    
    _newsData = [[NSMutableArray alloc] init];
    
    //parsage des news
    _parser = [[XMLParser alloc] init];
    _parser.delegate = self;
    
    NSString *rssURL = @"http://www.sujetsetcorriges.fr/rss";
    [self performSelectorInBackground:@selector(parseNews:) withObject:rssURL];
    
    
}

- (void) parseNews:(NSString*)theURL
{
    @autoreleasepool
    {
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        MBProgressHUD *chargementHUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        [chargementHUD setLabelText:@"Chargement"];
        [_parser parseXMLFileAtURL:theURL];
    }
}


- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
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
    return [_newsData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ActuCell";
    
    ActuCell *cell = (ActuCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[ActuCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    
    //configuration de la cellulle titre
    cell.titreCell.text = [[_newsData objectAtIndex:indexPath.row] objectForKey:@"title"];
    cell.titreCell.numberOfLines = 2;
    
    
    //configuation de la cellule date
    //définition des locales pour la date
    NSLocale *frLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"fr_FR"];
    NSLocale *usLocale = [[NSLocale alloc ] initWithLocaleIdentifier:@"en_US_POSIX" ];
    
    //conversion de la date en NSSDate
    NSString *date = [[_newsData objectAtIndex:indexPath.row] objectForKey:@"date"];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setLocale:usLocale];
    [dateFormatter setDateFormat:@"EEE, dd MMM yyyy HH:mm:ss '+0000'"];
    NSDate *convertedDate = [dateFormatter dateFromString:date];
    [dateFormatter setLocale:frLocale];
    [dateFormatter setDateFormat:@"dd/MM"];
    NSString *convertedStringDate = [dateFormatter stringFromDate:convertedDate];

    cell.dateCell.text = convertedStringDate;
    
    //renvoie de la cellule
    return cell;
}



#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ActuDetailViewController *actuDetailViewController = [[ActuDetailViewController alloc] init];
    
    actuDetailViewController.url = [[_newsData objectAtIndex:indexPath.row] objectForKey:@"link"];
    actuDetailViewController.texte = [[_newsData objectAtIndex:indexPath.row] objectForKey:@"summary"];
    actuDetailViewController.titre = [[_newsData objectAtIndex:indexPath.row] objectForKey:@"title"];
    actuDetailViewController.auteur = [[_newsData objectAtIndex:indexPath.row] objectForKey:@"author"];
    actuDetailViewController.date = [[_newsData objectAtIndex:indexPath.row] objectForKey:@"date"];
        
    [self.navigationController pushViewController:actuDetailViewController animated:YES];
}

//méthode pour le pull to refresh

- (void)pullToRefreshViewShouldRefresh:(PullToRefreshView *)view;
{
    NSString *rssURL = @"http://www.sujetsetcorriges.fr/rss";
    [self performSelectorInBackground:@selector(parseNews:) withObject:rssURL];
}


-(void)foregroundRefresh:(NSNotification *)notification
{
    self.tableView.contentOffset = CGPointMake(0, -65);
    [pull setState:PullToRefreshViewStateLoading];
    NSString *rssURL = @"http://www.sujetsetcorriges.fr/rss";
    [self performSelectorInBackground:@selector(parseNews:) withObject:rssURL];
}


#pragma mark - XMLParserDelegate
- (void) xmlParser:(XMLParser *)parser didFinishParsing:(NSArray *)array
{
    _newsData = _parser.XMLData;
    [self.tableView reloadData];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [pull finishedLoading];
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}

- (void) xmlParser:(XMLParser *)parser didFailWithError:(NSArray *)error
{
    
}

@end
