//
//  ContentPageSujetViewController.m
//  SetC : SujetsetCorriges
//
//  Created by Mestiri Hedi on 29/09/12.
//  Copyright (c) 2012 Mestiri Hedi. All rights reserved.
//

#import "ContentPageSujetViewController.h"

@interface ContentPageSujetViewController ()

@end

@implementation ContentPageSujetViewController

@synthesize tableSuj;
@synthesize listeSujCor = _listeSujCor;
@synthesize intro = _intro;
@synthesize introView = _introView;

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
    if ([_intro isEqualToString:@"intro"])
    {
        CGRect screenRect = [[UIScreen mainScreen] applicationFrame];
        CGFloat hauteurFenetre = screenRect.size.height - self.navigationController.navigationBar.frame.size.height - self.tabBarController.tabBar.frame.size.height;
        
        _introView = [[UIView alloc] initWithFrame:CGRectMake(0,0,self.view.frame.size.width, hauteurFenetre)];
        
        introLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, round(_introView.frame.size.height/3), _introView.frame.size.width, round(_introView.frame.size.height/3))];
        introLabel.text = @"Sélectionnez un concours";
        introLabel.textAlignment = UITextAlignmentCenter;
        
        [_introView addSubview:introLabel];
        [self.view addSubview:_introView];
    }
    else
    {
        CGRect screenRect = [[UIScreen mainScreen] applicationFrame];
        CGFloat hauteurFenetre = screenRect.size.height - self.navigationController.navigationBar.frame.size.height - self.tabBarController.tabBar.frame.size.height;
        
        tableSuj = [[UITableView alloc] initWithFrame:CGRectMake(0,0,self.view.frame.size.width, hauteurFenetre) style:UITableViewStyleGrouped];
        tableSuj.delegate = self;
        tableSuj.dataSource = self;
        [self.view addSubview:tableSuj];
    }

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_listeSujCor count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    NSDictionary *sujcor = [_listeSujCor objectAtIndex:[indexPath row]];
    cell.textLabel.text = [NSString stringWithFormat:@"%@", [sujcor objectForKey:kMatiere]];
    return cell;
}

@end
