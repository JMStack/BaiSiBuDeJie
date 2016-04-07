//
//  DJLoginRegisterField.m
//  BuDeJie
//
//  Created by Jack.Ma on 16/4/7.
//  Copyright © 2016年 Jack.Ma. All rights reserved.
//

#import "DJLoginRegisterField.h"

@implementation DJLoginRegisterField

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self addTarget:self action:@selector(editBegin:) forControlEvents:UIControlEventEditingDidBegin];
    [self addTarget:self action:@selector(editEnd:) forControlEvents:UIControlEventEditingDidEnd];
    
    self.placeholderColor = [UIColor lightGrayColor];
}

- (void)editBegin:(UITextField *)field {
    self.placeholderColor = [UIColor whiteColor];
}

- (void)editEnd:(UITextField *)field {
    self.placeholderColor = [UIColor lightGrayColor];
}

@end
