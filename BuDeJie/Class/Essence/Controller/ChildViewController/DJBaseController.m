//
//  DJBaseController.m
//  BuDeJie
//
//  Created by Jack.Ma on 16/4/9.
//  Copyright © 2016年 Jack.Ma. All rights reserved.
//

#import "DJBaseController.h"

@interface DJBaseController ()

@end

static NSString * const cellID = @"CellID";

@implementation DJBaseController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.contentInset = UIEdgeInsetsMake(kNavigationBarHeight + kHeadHegiht, 0,kTabBarHegiht, 0);
    self.tableView.scrollIndicatorInsets = UIEdgeInsetsMake(kNavigationBarHeight + kHeadHegiht, 0,kTabBarHegiht, 0);
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellID];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.tableView.delegate = self;
    
    self.view.backgroundColor = RandomColor;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPat {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    cell.backgroundColor = self.view.backgroundColor;
    return cell;
}
#pragma mark - Table view data source

@end
