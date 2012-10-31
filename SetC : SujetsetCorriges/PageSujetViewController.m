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

@synthesize pageController = pageController_;
@synthesize pageContent = pageContent_;
@synthesize concours = concours_;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        // Custom initialization
        concours_ = @"aucun";
    }
    return self;
}


- (void) createContentPages
{
    if ([concours_ isEqualToString:@"aucun"])
    {
        NSMutableArray *pageStrings = [[NSMutableArray alloc] init];
        NSString *temp = @"intro";
        [pageStrings addObject:temp];
        pageContent_ = [[NSArray alloc] initWithArray:pageStrings];
    }
    else
    {
        NSURL *url = [NSURL URLWithString:@"http://www.sujetsetcorriges.fr/gestionXML/extractXML"];
        ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
        [request setPostValue:concours_ forKey:@"concours"];
        [request startSynchronous];
        NSError *error = [request error];
        if (!error)
        {
            parser_ = [[XMLParser alloc] init];
            [parser_ parseXMLFileAtData:[request responseString]];
            
            //initialisation des variables
            NSDictionary *tempSujCor = [[NSDictionary alloc] init];
            NSString *tempMatiere = [[NSString alloc] init];
            
            //tableau des matières du concours
            NSMutableArray *tabMatiere = [[NSMutableArray alloc] init];
            
            //booléen pour savoir si la matière a déjà été rencontré
            BOOL found = NO;
            
            //dictionnaire avec clé le nom de matière et pour valeur un tableau contenant les éléments XML correspondant à la matière
            NSMutableDictionary *tabSujCor = [[NSMutableDictionary alloc] init];
            
            //pour chaque entrée du XML
            for (int i=0; i<[parser_.XMLData count]; i++)
            {
                //on prend l'entrée et on enregistre la matière
                tempSujCor = [parser_.XMLData objectAtIndex:i];
                tempMatiere= [tempSujCor objectForKey:kMatiere];

                //on recherche si la matière est dans le tableau
                for (NSString *mat in tabMatiere)
                {
                    if ([mat isEqualToString:tempMatiere])
                    {
                        found = YES;
                        break;
                    }
                }
                
                //si la matière n'a pas été trouvé
                if (!found)
                {
                    //on ajoute la matière dans le tableau
                    [tabMatiere addObject:tempMatiere];
                    
                    //on créé un tableau qui contiendra les éléments XML correspondant à une matière particulière
                    NSMutableArray *tabElement = [[NSMutableArray alloc] init];
                    
                    //on ajoute l'élément XML actuel dans le tableau d'ID
                    [tabElement addObject:tempSujCor];
                    
                    //on ajoute dans le dictionnaire le tableau d'élément avec pour clé le nom de la matière
                    [tabSujCor setObject:tabElement forKey:tempMatiere];
                    
                    found = NO;
                }
                else
                {
                    //la matière existe, dans un tableau d'élément existe pour cette matière, on l'enregistre
                    //NSMutableArray *tabElement = [[NSMutableArray alloc] init];
                    NSMutableArray *tabElement = [tabSujCor objectForKey:tempMatiere];
                    
                    //on rajoute à ce tableau l'élément actuel
                    [tabElement addObject:tempSujCor];
                    
                    //on remplace l'ancien tableau d'élément par le nouveau dans le dictionnaire
                    [tabSujCor setObject:tabElement forKey:tempMatiere];
                    
                    found = NO;
                }
            }
            
            //Organisation du tableau matière par ordre alphabétique
            NSArray *matiereOrdreAlphabetique = [tabMatiere sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
            
            NSMutableArray *pageStrings = [[NSMutableArray alloc] init];
            for (NSString *mat in matiereOrdreAlphabetique)
            {
                NSMutableArray *temp = [tabSujCor objectForKey:mat];
                [pageStrings addObject:temp];
            }
            
            pageContent_ = [[NSArray alloc] initWithArray:pageStrings];
        }
    }
    
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    MBProgressHUD *chargementHUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [chargementHUD setLabelText:@"Chargement"];
    
    [self createContentPages];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Left"
                                                                             style:UIBarButtonItemStyleBordered
                                                                            target:self
                                                                            action:@selector(showLeft:)];
    
    NSDictionary *options = [NSDictionary dictionaryWithObject:[NSNumber numberWithInteger:UIPageViewControllerSpineLocationMin] forKey: UIPageViewControllerOptionSpineLocationKey];
    
    
    self.pageController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options: options];
    
    pageController_.dataSource = self;
    [[pageController_ view] setFrame:[[self view] bounds]];
    
    ContentPageSujetViewController *initialViewController = [self viewControllerAtIndex:0];
    NSArray *viewControllers = [NSArray arrayWithObject:initialViewController];
    
    [pageController_ setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    
    [self addChildViewController:pageController_];
    [[self view] addSubview:[pageController_ view]];
    [pageController_ didMoveToParentViewController:self];
    
    [MBProgressHUD hideHUDForView:self.view animated:YES];
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
    if ([concours_ isEqualToString:@"aucun"])
    {
        dataViewController.intro = @"intro";
        return dataViewController;
    }
    else
    {
        dataViewController.listeSujCor = [self.pageContent objectAtIndex:index];
        dataViewController.intro = @"pasIntro";
        return dataViewController;
    }
    
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
- (void) parseXMLFile:(NSString*)theData
{
    @autoreleasepool
    {
        parser_ = [[XMLParser alloc] init];
        parser_.delegate = self;
        if ([parser_.XMLData count] == 0)
        {
            [parser_ parseXMLFileAtData:theData];
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
