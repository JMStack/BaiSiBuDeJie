//
//  DJMeController.m
//  BuDeJie
//
//  Created by Jack.Ma on 16/3/31.
//  Copyright © 2016年 Jack.Ma. All rights reserved.
//

#import "DJMeController.h"
#import "DJSettingController.h"
#import "DJMeSquareCell.h"
#import <AFNetworking.h>
#import <MJExtension.h>
#import "DJSquareItem.h"
#import "DJWebKitController.h"

@interface DJMeController () <UICollectionViewDataSource,UICollectionViewDelegate>
@property (strong, nonatomic) NSMutableArray <DJSquareItem *> *collectionArray;
@property (weak, nonatomic) UICollectionView *footerView;
@end

#define Column 4
#define ItemWH (ScreenW-(Column-1))/Column

@implementation DJMeController




- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"我的";
    [self setUpNavigatoinBar];
    
    self.tableView.sectionHeaderHeight = 0.001;
    self.tableView.sectionFooterHeight = 10;
    self.tableView.contentInset = UIEdgeInsetsMake(-25, 0, 0, 0);
    [self loadData];
    [self setUpTableViewFooterView];
}

#define RowCount ((array.count-1)/Column+1)

- (void)loadData {
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    NSDictionary *parameter = @{@"a" : @"square",
                                @"c"  : @"topic"
                               };
    [session GET:@"http://api.budejie.com/api/api_open.php" parameters:parameter progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSArray *array = responseObject[@"square_list"];
        _collectionArray = [DJSquareItem mj_objectArrayWithKeyValuesArray:array];
        NSInteger count = Column - array.count % Column;
        while (count--) {
            [_collectionArray addObject:[[DJSquareItem alloc] init]];
        }
        CGFloat height = RowCount * ItemWH + RowCount - 1;
        CGRect rect = CGRectMake(0, 0, ScreenW, height);
        self.footerView.frame = rect;
        self.tableView.tableFooterView = self.footerView;
        [self.footerView reloadData];
        [self.tableView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}

- (void)setUpNavigatoinBar {
    UIButton *settingButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [settingButton setImage:[UIImage imageNamed:@"mine-setting-icon"] forState:UIControlStateNormal];
    [settingButton setImage:[UIImage imageNamed:@"mine-setting-icon-click"] forState:UIControlStateHighlighted];
    [settingButton addTarget:self action:@selector(settinButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    [settingButton sizeToFit];
    UIBarButtonItem *settingBarItem = [[UIBarButtonItem alloc] initWithCustomView:settingButton];
    
    UIButton *nightModeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [nightModeButton setImage:[UIImage imageNamed:@"mine-moon-icon"] forState:UIControlStateNormal];
    [nightModeButton setImage:[UIImage imageNamed:@"mine-moon-icon-click"] forState:UIControlStateSelected];
    [nightModeButton addTarget:self action:@selector(nightModeButton:) forControlEvents:UIControlEventTouchUpInside];
    [nightModeButton sizeToFit];
    UIBarButtonItem *nightModeItem = [[UIBarButtonItem alloc] initWithCustomView:nightModeButton];
    
    self.navigationItem.rightBarButtonItems = @[settingBarItem,nightModeItem];
}
- (void)nightModeButton:(UIButton *)button {
    button.selected = !button.selected;
}
- (void)settinButtonTapped:(UIButton *)button{
    DJSettingController *viewController = [[DJSettingController alloc] init];
    
    [self.navigationController pushViewController:viewController animated:YES];
}


static NSString * const collectionCell = @"collectionCellID";

- (void)setUpTableViewFooterView {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumLineSpacing = 1;
    layout.minimumInteritemSpacing = 1;
    layout.itemSize = CGSizeMake(ItemWH,ItemWH);
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    collectionView.dataSource = self;
    collectionView.delegate = self;
    collectionView.backgroundColor = [UIColor colorWithHexString:@"#D7D7D7"];
    [collectionView registerNib:[UINib nibWithNibName:@"DJMeSquareCell" bundle:nil] forCellWithReuseIdentifier:collectionCell];
    self.tableView.tableFooterView = collectionView;
    
    self.footerView = collectionView;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.collectionArray.count;
}

- (DJMeSquareCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    DJMeSquareCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:collectionCell forIndexPath:indexPath];
    
    cell.item = self.collectionArray[indexPath.item];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    DJSquareItem *item = self.collectionArray[indexPath.item];
    if ([item.url containsString:@"mod:"]) {
        UIViewController *viewController = [[UIViewController alloc] init];
        viewController.view.backgroundColor = [UIColor whiteColor];
        [self.navigationController pushViewController:viewController animated:YES];
    } else {
        DJWebKitController *webKitController = [[DJWebKitController alloc] init];
        webKitController.url = item.url;
        [self.navigationController pushViewController:webKitController animated:YES];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
