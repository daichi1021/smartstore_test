//
//  TempViewController.m
//  SmartStore_Test
//
//  Created by テラスカイ on 2014/03/20.
//  Copyright (c) 2014年 Test. All rights reserved.
//

#import "TempViewController.h"
#import "SmartStoreInterface.h"

@interface TempViewController ()

@property (nonatomic, strong) NSArray *dataRows;

@end

@implementation TempViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"SmartStore Temp";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self getTempData];
}


- (void)getTempData
{
    NSArray *results = [[[SmartStoreInterface alloc] init] getAccount];
    if(results){
        _dataRows = results;
        [self.tableView reloadData];
    }
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_dataRows count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CellIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
        
    }
	UIImage *image = [UIImage imageNamed:@"icon.png"];
	cell.imageView.image = image;
    
	NSArray *obj = [_dataRows objectAtIndex:indexPath.row];
	cell.textLabel.text =  [obj objectAtIndex:1];
    
	cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
	return cell;
}

@end
