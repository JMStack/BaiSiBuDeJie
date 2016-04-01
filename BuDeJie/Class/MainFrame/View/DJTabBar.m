//
//  DJTabBar.m
//  BuDeJie
//
//  Created by Jack.Ma on 16/4/1.
//  Copyright © 2016年 Jack.Ma. All rights reserved.
//

#import "DJTabBar.h"

@interface DJTabBar ()

@property (weak, nonatomic) UIButton *publisButton;

@end

@implementation DJTabBar

- (UIButton *)publisButton {
    if (_publisButton == nil) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setImage:[UIImage imageNamed:@"tabBar_publish_icon"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"tabBar_publish_click_icon"] forState:UIControlStateSelected];
        [self addSubview:button];
        _publisButton = button;
    }
    return _publisButton;
}

- (void)addTarget:(nullable id)target action:(nonnull SEL)select  forControlEvents:(UIControlEvents)event {
    [self.publisButton addTarget:target action:select forControlEvents:event];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    //重新布局子tabarbutton
    NSInteger count = self.items.count + 1;
    //子控件位置变量
    CGFloat x;
    CGFloat y = 0;
    CGFloat W = self.frame.size.width / count;
    CGFloat H = self.frame.size.height;
    NSInteger index = 0;
    for (UIView *tabBarButton in self.subviews) {
        if ([tabBarButton isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            if (index == 2) {
                index += 1;
            }
            x = W * index++;
            tabBarButton.frame = CGRectMake(x, y, W, H);
        }
    }
    
    [self.publisButton sizeToFit];
    self.publisButton.center = CGPointMake(self.bounds.size.width * 0.5, self.bounds.size.height * 0.5);
}


@end
