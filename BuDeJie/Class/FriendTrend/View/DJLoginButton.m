//
//  DJLoginButton.m
//  BuDeJie
//
//  Created by Jack.Ma on 16/4/6.
//  Copyright © 2016年 Jack.Ma. All rights reserved.
//

#import "DJLoginButton.h"

@implementation DJLoginButton

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.imageView sizeToFit];
    [self.titleLabel sizeToFit];
    
    CGRect rect = self.titleLabel.frame;
    
    self.imageView.center = CGPointMake(self.frame.size.width * 0.5, self.frame.size.height * 0.5 - rect.size.height);
    
    self.titleLabel.center = CGPointMake(self.frame.size.width * 0.5, CGRectGetMaxY(self.imageView.frame) + rect.size.height * 0.5 + margin);
}

@end
