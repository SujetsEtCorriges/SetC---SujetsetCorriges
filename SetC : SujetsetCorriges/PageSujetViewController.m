//
//  PageSujetViewController.m
//  SetC : SujetsetCorriges
//
//  Created by Mestiri Hedi on 29/09/12.
//  Copyright (c) 2012 Mestiri Hedi. All rights reserved.
//

#import "PageSujetViewController.h"

@interface PageSujetViewController ()

@end

@implementation PageSujetViewController

@synthesize pageController, pageContent;
@synthesize concours = _concours;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        _concours = @"aucun";
    }
    return self;
}


- (void) createContentPages
{
    /*NSMutableArray *pageStrings = [[NSMutableArray alloc] init];
    for (int i = 1; i < 11; i++)
    {
        NSString *contentString = [[NSString alloc]
                                   initWithFormat:@"<html><head></head><body><h1>Chapter %d</h1><p>This is the page %d of content displayed using UIPageViewController in iOS 5.</p></body></html>", i, i];
        [pageStrings addObject:contentString];
    }
    pageContent = [[NSArray alloc] initWithArray:pageStrings];*/

    /*if ([_concours isEqualToString:@"aucun"])
    {
        
    }
    else
    {*/
        NSURL *url = [NSURL URLWithString:@"http://www.sujetsetcorriges.fr/gestionXML/extractXML"];
        ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
        [request setPostValue:_concours forKey:@"concours"];
        [request startSynchronous];
        NSError *error = [request error];
        if (!error)
        {
            _parser = [[XMLParser alloc] init];
            [_parser parseXMLFileAtPath:[request responseString]];
            
            NSMutableArray *pageStrings = [[NSMutableArray alloc] init];
            [pageStrings addObject:_parser.sujcor];
            [pageStrings addObject:_parser.sujcor];
            
            pageContent = [[NSArray alloc] initWithArray:pageStrings];
            NSLog(@"%u",[pageContent count]);
            
        }
    //}

    
        
        
        

    //NSString *xmlFilePath = @"http://www.sujetsetcorriges.fr/gestionXML/centrale_MP.xml";
    //_parser = [[XMLParser alloc] init];
    //[_parser parseXMLFileAtPath:xmlFilePath];
    
    
    //pas de background sinon contenu vide
    //[self performSelectorInBackground:@selector(parseXMLFile:) withObject:xmlFilePath];
    
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self createContentPages];
    
    self.title = @"Sujets et Corrigés";
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Left"
                                                                             style:UIBarButtonItemStyleBordered
                                                                            target:self
                                                                            action:@selector(showLeft:)];
    
    NSDictionary *options = [NSDictionary dictionaryWithObject:[NSNumber numberWithInteger:UIPageViewControllerSpineLocationMin] forKey: UIPageViewControllerOptionSpineLocationKey];
    
    
    self.pageController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options: options];
    
    pageController.dataSource = self;
    [[pageController view] setFrame:[[self view] bounds]];
    
    ContentPageSujetViewController *initialViewController = [self viewControllerAtIndex:0];
    NSArray *viewControllers = [NSArray arrayWithObject:initialViewController];
    
    [pageController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    
    [self addChildViewController:pageController];
    [[self view] addSubview:[pageController view]];
    [pageController didMoveToParentViewController:self];
    
    
}


- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    SectionListViewController *sectionList = [[SectionListViewController alloc] initWithStyle:UITableViewStylePlain];
    [self.revealSideViewController preloadViewController:sectionList forSide:PPRevealSideDirectionLeft];
}

- (void) showLeft:(id)sender
{
    // used to push a new controller, but we preloaded it !
    //    LeftViewController *left = [[LeftViewController alloc] initWithStyle:UITableViewStylePlain];
    //    [self.revealSideViewController pushViewController:left onDirection:PPRevealSideDirectionLeft animated:YES];
    
    [self.revealSideViewController pushOldViewControllerOnDirection:PPRevealSideDirectionLeft withOffset:120 animated:YES];
}

- (ContentPageSujetViewController *)viewControllerAtIndex:(NSUInteger)index
{
    // Return the data view controller for the given index.
    if (([self.pageContent count] == 0) || (index >= [self.pageContent count]))
    {
        return nil;
    }
    
    // Create a new view controller and pass suitable data.
    ContentPageSujetViewController *dataViewController = [[ContentPageSujetViewController alloc] initWithNibName:@"ContentPageSujetViewController" bundle:nil];
    dataViewController.listeSujCor = [self.pageContent objectAtIndex:index];
    return dataViewController;
}

- (NSUInteger)indexOfViewController:(ContentPageSujetViewController *)viewController
{
    return [self.pageContent indexOfObject:viewController.listeSujCor];
}


- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    NSUInteger index = [self indexOfViewController:(ContentPageSujetViewController *)viewController];
    if ((index == 0) || (index == NSNotFound))
    {
        return nil;
    }
    
    index--;
    
    return [self viewControllerAtIndex:index];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    NSUInteger index = [self indexOfViewController:(ContentPageSujetViewController *)viewController];
    if (index == NSNotFound)
    {
        return nil;
    }
    
    index++;
    
    if (index == [self.pageContent count])
    {
        return nil;
    }
    
    return [self viewControllerAtIndex:index];
}


#pragma mark - XMLParserDelegate
- (void) parseXMLFile:(NSString*)thePath
{
    @autoreleasepool {
        _parser = [[XMLParser alloc] init];
        _parser.delegate = self;
        if ([_parser.sujcor count] == 0)
        {
            [_parser parseXMLFileAtPath:thePath];
        }
    }
}

- (void) xmlParser:(XMLParser *)parser didFinishParsing:(NSArray *)array
{
    
}

- (void) xmlParser:(XMLParser *)parser didFailWithError:(NSArray *)error
{
    
}


@end
