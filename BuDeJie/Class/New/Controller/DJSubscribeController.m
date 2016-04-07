//
//  DJSubscribeController.m
//  BuDeJie
//
//  Created by Jack.Ma on 16/4/5.
//  Copyright © 2016年 Jack.Ma. All rights reserved.
//

#import "DJSubscribeController.h"
#import <AFNetworking.h>
#import <MJExtension.h>
#import "DJSubRowItem.h"
#import "DJSubscribeCell.h"

@interface DJSubscribeController ()

@property (strong, nonatomic) NSArray *rowItemArray;

@end
static NSString * const  cellID = @"SUBCELL";
@implementation DJSubscribeController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"标签订阅";
    // 加载数据
    [self loadData];
    //注册cell
    [self.tableView registerNib:[UINib nibWithNibName:@"DJSubscribeCell" bundle:nil] forCellReuseIdentifier:cellID];
    //不要cell分隔线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    //tableview背景色
    self.tableView.backgroundColor = [UIColor colorWithHexString:@"#D7D7D7"];
}

- (void)loadData {
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    
    NSDictionary *parameter = @{@"a"      : @"tag_recommend",
                                @"action" : @"sub",
                                @"c"      : @"topic"
                               };
    
    [session GET:@"http://api.budejie.com/api/api_open.php" parameters:parameter progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSArray *rowItemArray = [DJSubRowItem mj_objectArrayWithKeyValuesArray:responseObject];
        self.rowItemArray = rowItemArray;
        [self.tableView reloadData];
       
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.rowItemArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DJSubscribeCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    
    cell.item = self.rowItemArray[indexPath.row];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60.0f;
}

@end
