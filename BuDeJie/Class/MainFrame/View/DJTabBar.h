//
//  DJTabBar.h
//  BuDeJie
//
//  Created by Jack.Ma on 16/4/1.
//  Copyright © 2016年 Jack.Ma. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DJTabBar : UITabBar


- (void)addTarget:(nullable id)target action:(nonnull SEL)select  forControlEvents:(UIControlEvents)event;

@end
