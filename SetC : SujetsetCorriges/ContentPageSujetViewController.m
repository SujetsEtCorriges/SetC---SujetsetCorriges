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

@synthesize webView, dataObject, tableSuj;
@synthesize listeSujCor = _listeSujCor;

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
    //tableSuj = [[UITableView alloc] initWithFrame:CGRectMake(0,0,self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
    tableSuj.delegate = self;
    tableSuj.dataSource = self;
    NSLog(@"%u", [_listeSujCor count]);
    
    /*for (int i=0; i < [_listeSujCor count]; i++)
    {
        sujCorView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, hauteurBlocInfo)];
        
    }*/
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [webView loadHTMLString:dataObject baseURL:[NSURL URLWithString:@""]];
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
