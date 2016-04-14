//
//  DJAllController.m
//  BuDeJie
//
//  Created by Jack.Ma on 16/4/9.
//  Copyright © 2016年 Jack.Ma. All rights reserved.
//

#import "DJAllController.h"
#import <AFNetWorking.h>
#import "DJTopic.h"
#import <MJExtension.h>
#import <MJRefresh.h>
#import "DJTopicCell.h"

static NSString * const cellID = @"AllVCCellID";

@interface DJAllController ()

@property (strong, nonatomic) NSMutableArray *allRowItems;
@property (strong, nonatomic) NSString *maxtime;

@end

@implementation DJAllController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addNotificationObser];
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self loadNewNetworkData];
    }];
    
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [self loadMoreNetworkData];
    }];
    
    self.tableView.estimatedRowHeight = 170;
    [self.tableView registerNib:[UINib nibWithNibName:@"DJTopicCell" bundle:nil] forCellReuseIdentifier:cellID];
    [self loadNewNetworkData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)addNotificationObser {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tabBarButtonRepeatClick) name:TabBarNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tabBarButtonRepeatClick) name:TitleButtonNocification object:nil];
}

- (void)tabBarButtonRepeatClick {
    if (self.tableView.scrollsToTop == NO || self.tableView.window == nil) return; //当前view如果不在视图范围内不进行刷新
    [self.tableView.mj_header beginRefreshing];
}

#pragma mark - New working Data Process

static NSString * const type = @"1";

- (void)loadNewNetworkData {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    NSDictionary *paramter = @{ @"a" : @"list",
                                @"c"  : @"data",
                                @"type" : type
                              };
    [manager GET:BaseURL parameters:paramter progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        self.maxtime = responseObject[@"info"][@"maxtime"];
        self.allRowItems = [DJTopic mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        [self.tableView reloadData];
        [self.tableView.mj_footer endRefreshing];
        [self.tableView.mj_header endRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
        [self.tableView.mj_footer endRefreshing];
        [self.tableView.mj_header endRefreshing];
    }];
}

- (void)loadMoreNetworkData {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    NSDictionary *paramter = @{ @"a"       : @"list",
                                @"c"       : @"data",
                                @"maxtime" : self.maxtime,
                                @"type"    : type
                              };
    [manager GET:BaseURL parameters:paramter progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        self.maxtime = responseObject[@"info"][@"maxtime"];
        
        [self.allRowItems addObjectsFromArray:[DJTopic mj_objectArrayWithKeyValuesArray:responseObject[@"list"]]];
        [self.tableView reloadData];
        [self.tableView.mj_footer endRefreshing];
        [self.tableView.mj_header endRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
        [self.tableView.mj_footer endRefreshing];
        [self.tableView.mj_header endRefreshing];
    }];
}

#pragma mark - TableView Datasource & Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.allRowItems.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DJTopicCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];

    DJTopic *topicItem = self.allRowItems[indexPath.row];
    cell.topicItem = topicItem;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    DJTopic *topicItem = self.allRowItems[indexPath.row];
    
    return topicItem.rowHeight;
}


@end
