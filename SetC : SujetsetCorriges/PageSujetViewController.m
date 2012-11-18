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
        filiere_ = @"MP";
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
        if ([concours_ isEqualToString:@"Banque PT"])
            filiere_ = @"PT";
        else if ([concours_ isEqualToString:@"ENAC EPL"])
            filiere_ = @"NC";
        
        NSURL *url = [NSURL URLWithString:@"http://www.sujetsetcorriges.fr/gestionXML/extractXML"];
        ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
        [request setPostValue:concours_ forKey:@"concours"];
        [request setPostValue:filiere_ forKey:@"filiere"];
        [request startSynchronous];
        NSError *error = [request error];
        if (!error)
        {
            parser_ = [[XMLParser alloc] init];
            [parser_ parseXMLFileAtData:[request responseString]];
            
            //initialisation des variables temporaire
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
    
    if (![concours_ isEqualToString:@"Banque PT"] && ![concours_ isEqualToString:@"aucun"])
    {
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:filiere_ style:UIBarButtonItemStyleBordered target:self action:@selector(choixFiliere:)];
    }
    
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
    [self.revealSideViewController pushOldViewControllerOnDirection:PPRevealSideDirectionLeft withOffset:120 animated:YES];
}


- (void) choixFiliere:(id)sender
{
    tabFiliere_ = [[NSArray alloc] initWithObjects:@"MP", @"PC", @"PSI", nil];
        
    menu_ = [[UIActionSheet alloc] initWithTitle:@"Choix de la filiere"
                                                      delegate:self
                                             cancelButtonTitle:nil
                                        destructiveButtonTitle:nil
                                             otherButtonTitles:nil];
    
    [menu_ setActionSheetStyle:UIActionSheetStyleBlackTranslucent];
    
    
    CGRect pickerFrame = CGRectMake(0, 40, 0, 0);
    
    UIPickerView *pickerView = [[UIPickerView alloc] initWithFrame:pickerFrame];
    pickerView.showsSelectionIndicator = YES;
    pickerView.dataSource = self;
    pickerView.delegate = self;
    
    [pickerView selectRow:filiereRow_ inComponent:0 animated:YES];
    
    [menu_ addSubview:pickerView];
    
    
    UISegmentedControl *closeButton = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObject:@"OK"]];
    closeButton.momentary = YES;
    closeButton.frame = CGRectMake(260, 7.0f, 50.0f, 30.0f);
    closeButton.segmentedControlStyle = UISegmentedControlStyleBar;
    closeButton.tintColor = [UIColor blackColor];
    [closeButton addTarget:self action:@selector(changeFiliere:) forControlEvents:UIControlEventValueChanged];
    [menu_ addSubview:closeButton];

    [menu_ showInView:[[UIApplication sharedApplication] keyWindow]];
    
    [menu_ setBounds:CGRectMake(0, 0, 320, 485)];
}


- (void) changeFiliere:(id)sender
{    
    [menu_ dismissWithClickedButtonIndex:0 animated:YES];
    
    [self createContentPages];
    
    self.navigationItem.rightBarButtonItem.title = filiere_;
    
    ContentPageSujetViewController *initialViewController = [self viewControllerAtIndex:0];
    NSArray *viewControllers = [NSArray arrayWithObject:initialViewController];
    
    [pageController_ setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
}


// Méthode pour le page view controller
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
        dataViewController.intro = YES;
        return dataViewController;
    }
    else
    {
        dataViewController.listeSujCor = [self.pageContent objectAtIndex:index];
        dataViewController.intro = NO;
        dataViewController.concours = concours_;
        dataViewController.filiere = filiere_;
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


// Méthodes pour le picker view
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)thePickerView
{
    
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)thePickerView numberOfRowsInComponent:(NSInteger)component
{
    
    return 3;
}

- (NSString *)pickerView:(UIPickerView *)thePickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [tabFiliere_ objectAtIndex:row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    filiereRow_ = row;
    filiere_ = [tabFiliere_ objectAtIndex:row];
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
