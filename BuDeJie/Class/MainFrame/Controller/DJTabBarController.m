//
//  DJTabBarController.m
//  BuDeJie
//
//  Created by Jack.Ma on 16/3/31.
//  Copyright © 2016年 Jack.Ma. All rights reserved.
//

#import "DJTabBarController.h"
#import "DJNavigationController.h"
#import "DJPublishController.h"
#import "DJEssenceController.h"
#import "DJMeController.h"
#import "DJNewController.h"
#import "DJFriendTrendController.h"
#import "DJTabBar.h"

@interface DJTabBarController ()

@end

@implementation DJTabBarController

+ (void)load {
    //设置item选中时的体字颜色
    [self setUpItemTitleColor];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //重新设置自定义tabbar
    DJTabBar *tabbar = [[DJTabBar alloc] init];
    [tabbar addTarget:self action:@selector(publishTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self setValue:tabbar forKeyPath:@"tabBar"];
    //设置所有的子控制器
    [self addAllOfChildViewController];

}

- (void)publishTapped:(UIButton *)button {
    debugMethod();
}

- (void)addAllOfChildViewController {
    //添加精华页
    [self addOneChileRootViewController:[DJEssenceController class] title:@"精华" withItemImageNaem:@"tabBar_essence_icon" selectItemImage:@"tabBar_essence_click_icon"];
    
    //添加朋友状态
    [self addOneChileRootViewController:[DJFriendTrendController class] title:@"朋友" withItemImageNaem:@"tabBar_friendTrends_icon" selectItemImage:@"tabBar_friendTrends_click_icon"];
    
    //添加发布页
//    [self addOneChileRootViewController:[DJPublishController class] title:nil withItemImageNaem:@"tabBar_publish_icon" selectItemImage:@"tabBar_publish_click_icon"];
    
    //添加动态页
    [self addOneChileRootViewController:[DJNewController class] title:@"动态" withItemImageNaem:@"tabBar_new_icon" selectItemImage:@"tabBar_new_click_icon"];
    
    //添加我页
    [self addOneChileRootViewController:[DJMeController class] title:@"我" withItemImageNaem:@"tabBar_me_icon" selectItemImage:@"tabBar_me_click_icon"];
    
}


- (void)addOneChileRootViewController:(Class)class title:(NSString *)title withItemImageNaem:(NSString *)name selectItemImage:(NSString *)seletName {
    if (title != nil) {
        UIViewController *rootViewController = [[class alloc] init];
        rootViewController.tabBarItem.title = title;
        rootViewController.tabBarItem.image = [UIImage imageNameWithOriginal:name];
        rootViewController.tabBarItem.selectedImage = [UIImage imageNameWithOriginal:seletName];
        DJNavigationController *controller = [[DJNavigationController alloc] initWithRootViewController:rootViewController];
        [self addChildViewController:controller];
    } else {
        UIViewController *controller = [[class alloc] init];
        controller.tabBarItem.image = [UIImage imageNameWithOriginal:name];
        controller.tabBarItem.selectedImage = [UIImage imageNameWithOriginal:seletName];
        [self addChildViewController:controller];
    }
}

+ (void)setUpItemTitleColor {
    UITabBarItem *tabbarItem = [UITabBarItem appearance];
    //选中情况下字体
    NSDictionary *attributesSelect = @{NSForegroundColorAttributeName : [UIColor blackColor],
                                       NSFontAttributeName            : [UIFont systemFontOfSize:13]
                                       };
    [tabbarItem setTitleTextAttributes:attributesSelect forState:UIControlStateNormal];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
