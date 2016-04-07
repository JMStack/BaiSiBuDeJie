//
//  DJSettingController.m
//  BuDeJie
//
//  Created by Jack.Ma on 16/4/1.
//  Copyright © 2016年 Jack.Ma. All rights reserved.
//

#import "DJSettingController.h"

@interface DJSettingController ()

@end


#define CachePath NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0]

@implementation DJSettingController


static NSString * const cellID = @"SettingCellID";

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"设置";
    self.view.backgroundColor = [UIColor whiteColor];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellID];
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
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    cell.textLabel.text = [NSString stringWithFormat:@"清除缓存 (%@)",[self getFileSizeString]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //清除缓存文件    
    NSFileManager *manager = [NSFileManager defaultManager];
   
    [manager removeAllItemsOfFileDirectory:CachePath];
    
    [self.tableView reloadData];
}

- (NSString *)getFileSizeString {
    NSFileManager *manager = [NSFileManager defaultManager];
    NSUInteger size = [manager totalSizeOfFileDirectory:CachePath];
    if (size >= 1000 * 1000) {
        return [NSString stringWithFormat:@"%.fMB",size / (1000.0 * 1000.0)];
    } else if (size >= 1000) {
        return [NSString stringWithFormat:@"%.fKB",size / (1000.0)];
    } else {
        return [NSString stringWithFormat:@"%.fKB", 0.0f];
    }
}

@end
