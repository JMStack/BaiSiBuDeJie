//
//  UITextField+PlaceholderColor.m
//  BuDeJie
//
//  Created by Jack.Ma on 16/4/7.
//  Copyright © 2016年 Jack.Ma. All rights reserved.
//

#import "UITextField+PlaceholderColor.h"

@implementation UITextField (PlaceholderColor)


- (void)setPlaceholderColor:(UIColor *)placeholderColor {
    if (self.placeholder == nil) {
        self.placeholder = @" ";
    }
    [self setValue:placeholderColor forKeyPath:@"placeholderLabel.textColor"];
}

- (UIColor *)placeholderColor {
    return nil;
}


@end
