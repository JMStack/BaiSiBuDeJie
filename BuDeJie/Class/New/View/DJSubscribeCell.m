//
//  DJSubscribeCell.m
//  BuDeJie
//
//  Created by Jack.Ma on 16/4/5.
//  Copyright © 2016年 Jack.Ma. All rights reserved.
//

#import "DJSubscribeCell.h"
#import "DJSubRowItem.h"
#import "UIImageView+WebCache.h"

@interface DJSubscribeCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconImage;
@property (weak, nonatomic) IBOutlet UILabel *titleText;
@property (weak, nonatomic) IBOutlet UILabel *subNumberText;
@property (weak, nonatomic) IBOutlet UIButton *subscribeButton;

@property (strong, nonatomic) UIImage *placeholder;

@end

@implementation DJSubscribeCell

- (UIImage *)placeholder {
    if (_placeholder == nil) {
        UIImage *originImage = [UIImage imageNamed:@"defaultUserIcon"];
        _placeholder = [originImage circleImage];
    }
    return _placeholder;
}

- (void)setItem:(DJSubRowItem *)item {
    _item = item;
    
    self.titleText.text = item.theme_name;
    if (item.sub_number > 10000) {
        NSInteger subNumber = item.sub_number / 10000;
        NSString *text = [NSString stringWithFormat:@"%zd万人定阅",subNumber];
        self.subNumberText.text = text;
    } else {
        NSString *text = [NSString stringWithFormat:@"%zd人定阅",item.sub_number];
        self.subNumberText.text = text;
    }
    
    [self.iconImage sd_setImageWithURL:[NSURL URLWithString:item.image_list] placeholderImage:self.placeholder completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (image == nil) {
            return ;
        }
        self.iconImage.image = [image circleImage];
    }];
    
}



- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
