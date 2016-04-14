//
//  DJEssenceController.m
//  BuDeJie
//
//  Created by Jack.Ma on 16/3/31.
//  Copyright © 2016年 Jack.Ma. All rights reserved.
//

#import "DJEssenceController.h"
#import "DJAllController.h"
#import "DJPhotoController.h"
#import "DJVideoController.h"
#import "DJSoundController.h"   
#import "DJTextController.h"



@interface DJEssenceController () <UIScrollViewDelegate>
@property (weak, nonatomic) UIButton *previousSeletedButton;
@property (weak, nonatomic) UIView *indicatorView;
@property (weak, nonatomic) UIScrollView *scrollView;
@property (weak, nonatomic) UIScrollView *headTitleView;
@property (assign, nonatomic) NSUInteger subPageCount;

@end

@implementation DJEssenceController

#pragma mark -- Controller View Life Circle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self loadAllViewController];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self setUpNavigationBarStyle];
    // Add Main Content View
    [self setUpHeadTitleView];
    [self addMainScrollView];
    //Init The First View
    [self loadViewControllerViewAtIndex:0 addInView:_scrollView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadAllViewController {
    
    NSArray <Class> *objectType = @[[DJAllController class],[DJPhotoController class],[DJVideoController class],[DJSoundController class],[DJTextController class]];
    for ( Class class in objectType) {
        [self addChildViewController:[[class alloc] init]];
    }
}

#pragma mark -- Head Title View 



- (void)setUpHeadTitleView {
    CGFloat y = self.navigationController? 64 : 0;
    CGRect rect = CGRectMake(0, y, self.view.width, kHeadHegiht);
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:rect];
    scrollView.backgroundColor = [UIColor colorWithWhite:1 alpha:0.8];
    scrollView.scrollsToTop = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:scrollView];
    _headTitleView = scrollView;
    // Add Sub Button
    [self addAllOfTheButtonInView:scrollView];
    // ADD Red Indicator View
    [self addRedIndicatorInView:scrollView];
}

#define INDICATOR 3

- (void)addRedIndicatorInView:(UIView *)view {
    UIView *indicatorView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, INDICATOR)];
    indicatorView.backgroundColor = [UIColor redColor];
    [view addSubview:indicatorView];
    _indicatorView = indicatorView;
    // Set Init Frame For The Indicator
    UIButton *firstButton = view.subviews[0];
    if ([firstButton isKindOfClass:[UIButton class]]) {
        CGFloat width = [firstButton.titleLabel.text sizeWithAttributes:@{NSFontAttributeName : firstButton.titleLabel.font}].width;
        CGFloat x = firstButton.center.x;
        CGFloat y = view.height - INDICATOR + INDICATOR / 2;
        indicatorView.width  = width;
        indicatorView.center = CGPointMake(x, y);
    }
}


- (void)addAllOfTheButtonInView:(UIScrollView *)view {
    NSArray *titleArray = @[@"全部",@"视频",@"声音",@"图片",@"段子"];
    _subPageCount = titleArray.count;
    NSInteger index = 0;
    CGFloat width = view.width / titleArray.count;
    for (NSString *title in titleArray) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:title forState:UIControlStateNormal];
        [button setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        button.titleLabel.font = [UIFont systemFontOfSize:16];
        button.tag = index;
        [button addTarget:self action:@selector(titleButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:button];
        // Set Button Frame
        CGFloat x = width * index++;
        button.frame = CGRectMake(x, 0, width, view.height);
    }
}

- (void)titleButtonTapped:(UIButton *)button {
    if (_previousSeletedButton == button ) {
        [[NSNotificationCenter defaultCenter] postNotificationName:TitleButtonNocification object:nil];
        return;
    }
    _previousSeletedButton.selected = !_previousSeletedButton;
    button.selected = !button.selected;
    CGPoint point = _indicatorView.center;
    point.x = button.center.x;
    [UIView animateWithDuration:0.3 animations:^{
        _indicatorView.center = point;
    } completion:^(BOOL finished) {
        [self loadViewControllerViewAtIndex:button.tag addInView:_scrollView];
    }];
    CGFloat x = button.tag * _scrollView.width;
    [_scrollView setContentOffset:CGPointMake(x, _scrollView.contentOffset.y) animated:YES];
    
    // 对已添加的tableview,让其始终只有一个可以点击状态栏回到顶部
    UITableViewController *preVC = self.childViewControllers[_previousSeletedButton.tag];
    if ([preVC isViewLoaded]) {
        preVC.tableView.scrollsToTop = NO;
    }
    UITableViewController *currentVC = self.childViewControllers[button.tag];
    if ([currentVC isViewLoaded]) {
        currentVC.tableView.scrollsToTop = YES;
    }
    
    _previousSeletedButton = button;
}

#pragma mark -- Add Main Scroll View
- (void)addMainScrollView {
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    scrollView.contentSize = CGSizeMake(scrollView.width * _subPageCount, 0);
    scrollView.pagingEnabled = YES;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.scrollsToTop = NO;
    scrollView.delegate = self;
    [self.view insertSubview:scrollView atIndex:0];
    scrollView.backgroundColor = [UIColor lightGrayColor];
    _scrollView = scrollView;
}

- (void)loadViewControllerViewAtIndex:(NSInteger)index addInView:(UIScrollView *)scrollView {
    UIViewController *viewController = self.childViewControllers[index];
    UITableView *childView = (UITableView *)viewController.view;
    if (childView.superview != nil) return;
    // 新添加的tableview肯定是当前可视的,必需让其可以点击状态栏回到顶部
    childView.scrollsToTop = YES;
    CGRect rect = CGRectMake(scrollView.width * index, 0, scrollView.width, scrollView.height);
    childView.frame = rect;
    [scrollView addSubview:childView];
}

#pragma mark -- UIScrollView Delegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSUInteger index = scrollView.contentOffset.x / scrollView.width;
    UIButton *button = _headTitleView.subviews[index];
    if (_previousSeletedButton == button) return;
    [self titleButtonTapped:button];
}


#pragma mark -- Navigation Bar Style

- (void)setUpNavigationBarStyle {
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftButton setImage:[UIImage imageNamed:@"nav_item_game_icon"] forState:UIControlStateNormal];
    [leftButton setImage:[UIImage imageNamed:@"nav_item_game_click_icon"] forState:UIControlStateHighlighted];
    [leftButton sizeToFit];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
    
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightButton setImage:[UIImage imageNamed:@"navigationButtonRandom"] forState:UIControlStateNormal];
    [rightButton setImage:[UIImage imageNamed:@"navigationButtonRandomClick"] forState:UIControlStateHighlighted];
    [rightButton sizeToFit];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
}

@end
