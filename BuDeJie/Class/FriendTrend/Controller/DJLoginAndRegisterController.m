//
//  DJLoginAndRegisterContrller.m
//  BuDeJie
//
//  Created by Jack.Ma on 16/4/6.
//  Copyright © 2016年 Jack.Ma. All rights reserved.
//

#import "DJLoginAndRegisterController.h"
#import "DJLoginAndRegisterView.h"

@interface DJLoginAndRegisterController ()
@property (weak, nonatomic) IBOutlet UIView *loginAndRegisterView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leadingConstant;

@end

@implementation DJLoginAndRegisterController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
//    self.view.translatesAutoresizingMaskIntoConstraints = NO;
    // 设置登录/注册视图
    [self setUpLoginAndRegisterView];
    
    
}


- (void)setUpLoginAndRegisterView {
    DJLoginAndRegisterView *loginView = [DJLoginAndRegisterView loadLoginNibView];
    [self.loginAndRegisterView addSubview:loginView];
    DJLoginAndRegisterView *registerView = [DJLoginAndRegisterView loadRegisterNibView];
    [self.loginAndRegisterView addSubview:registerView];
}


- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    NSLog(@"%@",NSStringFromCGRect(self.loginAndRegisterView.frame));
    DJLoginAndRegisterView *loginView = [self.loginAndRegisterView.subviews firstObject];
    loginView.frame = CGRectMake(0, 0, self.loginAndRegisterView.frame.size.width * 0.5, self.loginAndRegisterView.frame.size.height);
    
    DJLoginAndRegisterView *registerView = [self.loginAndRegisterView.subviews lastObject];
    registerView.frame = CGRectMake(ScreenW, 0, self.loginAndRegisterView.frame.size.width * 0.5, self.loginAndRegisterView.frame.size.height);
}
- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)dismissViewController:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)loginOrRegister:(UIButton *)sender {
    sender.selected = !sender.selected;
    self.leadingConstant.constant = self.leadingConstant.constant == 0 ? -ScreenW : 0 ;
    [UIView animateWithDuration:0.5 animations:^{
        [self.view layoutIfNeeded];
    }];
}

@end
