//
//  DJMeSquareCell.m
//  BuDeJie
//
//  Created by Jack.Ma on 16/4/7.
//  Copyright © 2016年 Jack.Ma. All rights reserved.
//

#import "DJMeSquareCell.h"
#import <UIImageView+WebCache.h>
#import "DJSquareItem.h"

@interface DJMeSquareCell ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *textLabel;
@end

@implementation DJMeSquareCell

- (void)setItem:(DJSquareItem *)item {
    _item = item;
    
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:item.icon]];
    self.textLabel.text = item.name;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

@end
