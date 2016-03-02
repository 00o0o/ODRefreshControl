//
//  ViewController.m
//  ODRefreshControlDemo
//
//  Created by Fabio Ritrovato on 7/4/12.
//  Copyright (c) 2012 orange in a day. All rights reserved.
//

#import "ViewController.h"
#import "ODRefreshControl.h"
#import "ODLoadMoreControl.h"

@interface ViewController ()

@property (nonatomic, strong) NSMutableArray *datas;

@end
@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSArray *data = @[@"A", @"B", @"C", @"D", @"E"];
    _datas = [NSMutableArray arrayWithArray:data];
    [_datas addObjectsFromArray:data];
    [_datas addObjectsFromArray:data];

    ODRefreshControl *refreshControl = [[ODRefreshControl alloc] initInScrollView:self.tableView];
    [refreshControl addTarget:self action:@selector(dropViewDidBeginRefreshing:) forControlEvents:UIControlEventValueChanged];
    
    ODLoadMoreControl *loadMoreControl = [[ODLoadMoreControl alloc] initInScrollView:self.tableView];
    [loadMoreControl addTarget:self action:@selector(pullViewDidBeginLoading:) forControlEvents:UIControlEventValueChanged];
    loadMoreControl.hasmore = YES;
}

- (void)dealloc {

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if(!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    cell.textLabel.text = _datas[indexPath.row];
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _datas.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}

- (void)dropViewDidBeginRefreshing:(ODRefreshControl *)refreshControl
{
    double delayInSeconds = 3.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [refreshControl endRefreshing];
    });
}

- (void)pullViewDidBeginLoading:(ODLoadMoreControl *)loadMoreControl
{
    double delayInSeconds = 3.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [_datas addObjectsFromArray:@[@"f", @"a", @"b", @"c", @"d", @"e"]];
        [self.tableView reloadData];
        //loadMoreControl.hasmore = NO;
        [loadMoreControl endLoading];
    });
}

@end
