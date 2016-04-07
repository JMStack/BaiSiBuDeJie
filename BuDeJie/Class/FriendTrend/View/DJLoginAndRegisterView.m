//
//  DJLoginAndRegisterView.m
//  BuDeJie
//
//  Created by Jack.Ma on 16/4/6.
//  Copyright © 2016年 Jack.Ma. All rights reserved.
//

#import "DJLoginAndRegisterView.h"

@implementation DJLoginAndRegisterView

+ (instancetype)loadLoginNibView {
    return [[[NSBundle mainBundle] loadNibNamed:@"DJLoginAndRegisterView" owner:nil options:nil] firstObject];
}

+ (instancetype)loadRegisterNibView {
    return [[[NSBundle mainBundle] loadNibNamed:@"DJLoginAndRegisterView" owner:nil options:nil] lastObject];
}


@end
