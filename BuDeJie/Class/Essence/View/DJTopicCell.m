//
//  DJTopicCell.m
//  BuDeJie
//
//  Created by Jack.Ma on 16/4/14.
//  Copyright © 2016年 Jack.Ma. All rights reserved.
//

#import "DJTopicCell.h"
#import <UIImageView+WebCache.h>
#import "DJTopic.h"

@interface DJTopicCell ()
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *passTime;
@property (weak, nonatomic) IBOutlet UILabel *text;
@property (weak, nonatomic) IBOutlet UILabel *hotcomment;
@property (weak, nonatomic) IBOutlet UIButton *like;
@property (weak, nonatomic) IBOutlet UIButton *hate;
@property (weak, nonatomic) IBOutlet UIButton *share;
@property (weak, nonatomic) IBOutlet UIButton *comment;
@property (weak, nonatomic) IBOutlet UIView *commentView;

@end



@implementation DJTopicCell

- (void)setTopicItem:(DJTopic *)topicItem {
    _topicItem = topicItem;
    
    [self.icon sd_setImageWithURL:[NSURL URLWithString:topicItem.profile_image] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    
    self.name.text = topicItem.name;
    self.passTime.text = topicItem.passtime;
    self.text.text = topicItem.text;

    
    [self realStringNumber:topicItem.love ToDisplayOnButton:self.like placeholder:@"赞"];
    [self realStringNumber:topicItem.hate ToDisplayOnButton:self.hate placeholder:@"踩"];
    [self realStringNumber:topicItem.repost ToDisplayOnButton:self.share placeholder:@"分享"];
    [self realStringNumber:topicItem.comment ToDisplayOnButton:self.comment placeholder:@"评论"];
    
    if (self.topicItem.top_cmt.count) {
        self.commentView.hidden = NO;
        NSString *name = topicItem.top_cmt.firstObject[@"user"][@"username"];
        NSString *content= topicItem.top_cmt.firstObject[@"content"];
        if (content.length) {
            self.hotcomment.text = [NSString stringWithFormat:@"%@: %@",name,content];
        } else {
            self.hotcomment.text = [NSString stringWithFormat:@"%@: " ,@"语音评论"];
        }
        
    } else {
        self.commentView.hidden = YES;
    }
    
}

- (void)realStringNumber:(NSString *)nubmber ToDisplayOnButton:(UIButton *)button placeholder:(NSString *)placeholder{
    if (nubmber.integerValue >= 10000) {
        CGFloat temp = nubmber.integerValue / 10000.0;
        [button setTitle:[NSString stringWithFormat:@"%.1f万",temp] forState:UIControlStateNormal];
    } else if (nubmber.integerValue > 0) {
        [button setTitle:nubmber forState:UIControlStateNormal];
    } else {
        [button setTitle:placeholder forState:UIControlStateNormal];
    }
}

- (void)setFrame:(CGRect)frame {
    frame.size.height -= margin;
    [super setFrame:frame];
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
