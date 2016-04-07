//
//  DJFriendTrendController.m
//  BuDeJie
//
//  Created by Jack.Ma on 16/3/31.
//  Copyright © 2016年 Jack.Ma. All rights reserved.
//

#import "DJFriendTrendController.h"
#import "DJLoginAndRegisterController.h"

@interface DJFriendTrendController ()

@end

@implementation DJFriendTrendController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"我的关注";
    [self setUpNavigationBar];
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)setUpNavigationBar {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:@"friendsRecommentIcon"] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"friendsRecommentIcon-click"] forState:UIControlStateHighlighted];
    [button addTarget:self action:@selector(friendSRecomment:) forControlEvents:UIControlEventTouchUpInside];
    [button sizeToFit];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
}

- (void)friendSRecomment:(UIButton *)button {
    debugMethod();
}
- (IBAction)loginOrRegister:(id)sender {
    DJLoginAndRegisterController *viewController = [[DJLoginAndRegisterController alloc] init];
    [self presentViewController:viewController animated:YES completion:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
