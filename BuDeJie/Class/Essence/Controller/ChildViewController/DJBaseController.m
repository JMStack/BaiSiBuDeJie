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
    self.tableView.scrollsToTop = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor colorWithHexString:@"#dfdfdf"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    cell.backgroundColor = RandomColor;
    cell.textLabel.text = [NSString stringWithFormat:@"%zd",indexPath.row];
    return cell;
}
#pragma mark - Table view data source

@end
