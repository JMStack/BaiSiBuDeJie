//
//  DJTabBarController.m
//  BuDeJie
//
//  Created by Jack.Ma on 16/3/31.
//  Copyright © 2016年 Jack.Ma. All rights reserved.
//

#import "DJTabBarController.h"
#import "DJNavigationController.h"
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
    
    //添加新贴页
    [self addOneChileRootViewController:[DJNewController class] title:@"新贴" withItemImageNaem:@"tabBar_new_icon" selectItemImage:@"tabBar_new_click_icon"];
    
    //添加关注
    [self addOneChileRootViewController:[DJFriendTrendController class] title:@"关注" withItemImageNaem:@"tabBar_friendTrends_icon" selectItemImage:@"tabBar_friendTrends_click_icon"];
    
    //添加我页
 //   [self addOneChileRootViewController:[DJMeController class] title:@"我" withItemImageNaem:@"tabBar_me_icon" selectItemImage:@"tabBar_me_click_icon"];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"DJMeController" bundle:nil];
    UIViewController *meViewController = [storyboard instantiateInitialViewController];
    meViewController.tabBarItem.title = @"我";
    meViewController.tabBarItem.image = [UIImage imageNamed:@"tabBar_me_icon"];
    meViewController.tabBarItem.selectedImage = [UIImage imageNamed:@"tabBar_me_click_icon"];
    DJNavigationController *controller = [[DJNavigationController alloc] initWithRootViewController:meViewController];
    [self addChildViewController:controller];
}


- (void)addOneChileRootViewController:(Class)class title:(NSString *)title withItemImageNaem:(NSString *)name selectItemImage:(NSString *)seletName {

        UIViewController *rootViewController = [[class alloc] init];
        rootViewController.tabBarItem.title = title;
        rootViewController.tabBarItem.image = [UIImage imageNameWithOriginal:name];
        rootViewController.tabBarItem.selectedImage = [UIImage imageNameWithOriginal:seletName];
        DJNavigationController *controller = [[DJNavigationController alloc] initWithRootViewController:rootViewController];
        [self addChildViewController:controller];
}

+ (void)setUpItemTitleColor {
//    UITabBarItem *tabBarItem = [UITabBarItem appearanceWhenContainedIn:[DJTabBar class], nil];
    UITabBarItem *tabBarItem = [UITabBarItem appearanceWhenContainedInInstancesOfClasses:@[[DJTabBar class]]];
    //选中情况下字体
    NSDictionary *attributesSelect = @{ NSForegroundColorAttributeName : [UIColor blackColor],
                                        NSFontAttributeName            : [UIFont systemFontOfSize:13]
                                      };
    [tabBarItem setTitleTextAttributes:attributesSelect forState:UIControlStateNormal];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
