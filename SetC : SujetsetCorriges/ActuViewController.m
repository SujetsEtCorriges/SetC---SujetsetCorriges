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
@synthesize parseResults = _parseResults;

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
    
    self.title = @"Actualité";    
    //notification de rafraichissement
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(foregroundRefresh:)
                                                 name:UIApplicationWillEnterForegroundNotification
                                               object:nil];
    
    //initialisation de la vue pull to refresh
    pull = [[PullToRefreshView alloc] initWithScrollView:(UIScrollView *) self.tableView];
    [pull setDelegate:self];
    [self.tableView addSubview:pull];
    
    //parsage des news
    /*KMXMLParser *parser = [[KMXMLParser alloc]  initWithURL:@"http://www.sujetsetcorriges.fr/rss" delegate:nil]; //possibilite dans le delegate de faire une action, par exemple mettre un truc de chargement
    _parseResults = [parser posts];*/
    NSString *rssURL = @"http://www.sujetsetcorriges.fr/rss";
    [self performSelectorInBackground:@selector(parseNews:) withObject:rssURL];
    
    
}

- (void) parseNews:(NSString*)theURL
{
    @autoreleasepool {
        KMXMLParser *parser = [[KMXMLParser alloc] initWithURL:theURL delegate:nil];
        parser.delegate = self;
        if ([_parseResults count] == 0)
        {
            _parseResults = [parser posts];
            [self.tableView reloadData];
        }
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
    return self.parseResults.count;
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
    cell.titreCell.text = [[self.parseResults objectAtIndex:indexPath.row] objectForKey:@"title"];
    cell.titreCell.numberOfLines = 2;
    
    
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

    cell.dateCell.text = convertedStringDate;
    
    //renvoie de la cellule
    return cell;
}



#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ActuDetailViewController *actuDetailViewController = [[ActuDetailViewController alloc] init];
    
    actuDetailViewController.url = [[self.parseResults objectAtIndex:indexPath.row] objectForKey:@"link"];
    actuDetailViewController.texte = [[self.parseResults objectAtIndex:indexPath.row] objectForKey:@"summary"];
    actuDetailViewController.titre = [[self.parseResults objectAtIndex:indexPath.row] objectForKey:@"title"];
    actuDetailViewController.auteur = [[self.parseResults objectAtIndex:indexPath.row] objectForKey:@"author"];
    actuDetailViewController.date = [[self.parseResults objectAtIndex:indexPath.row] objectForKey:@"date"];
        
    [self.navigationController pushViewController:actuDetailViewController animated:YES];
}

//méthode pour le pull to refresh

- (void)pullToRefreshViewShouldRefresh:(PullToRefreshView *)view;
{
    [self performSelectorInBackground:@selector(reloadTableData) withObject:nil];
}


-(void) reloadTableData
{
    // call to reload your data
    //parsage des news
    KMXMLParser *parser = [[KMXMLParser alloc]  initWithURL:@"http://www.sujetsetcorriges.fr/rss" delegate:nil]; //possibilite dans le delegate de faire une action, par exemple mettre un truc de chargement
    _parseResults = [parser posts];
    [self.tableView reloadData];
    [pull finishedLoading];
}

-(void)foregroundRefresh:(NSNotification *)notification
{
    self.tableView.contentOffset = CGPointMake(0, -65);
    [pull setState:PullToRefreshViewStateLoading];
    [self performSelectorInBackground:@selector(reloadTableData) withObject:nil];
}

#pragma mark - KMXMLParserDelegate
- (void)parserDidFailWithError:(NSError *)error
{
    
}

- (void)parserCompletedSuccessfully
{
    
}

- (void)parserDidBegin
{
    
}

@end
