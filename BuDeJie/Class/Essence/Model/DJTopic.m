//
//  DJTopic.m
//  BuDeJie
//
//  Created by Jack.Ma on 16/4/14.
//  Copyright © 2016年 Jack.Ma. All rights reserved.
//

#import "DJTopic.h"

@implementation DJTopic

- (CGFloat)rowHeight {
    if (_rowHeight) return _rowHeight;
    
    _rowHeight += 53;
    
    _rowHeight += [_text boundingRectWithSize:CGSizeMake(ScreenW - margin * 2, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:16] } context:nil].size.height;
    _rowHeight += margin;
    if (_top_cmt.count) {
        _rowHeight += 17;
        
        NSString *name = _top_cmt.firstObject[@"user"][@"username"];
        NSString *content= _top_cmt.firstObject[@"content"];;
        if (!content.length) content = @"[语音评论]";
        NSString *comment = [NSString stringWithFormat:@"%@: %@",name,content];
        _rowHeight += [comment boundingRectWithSize:CGSizeMake(ScreenW - margin * 2, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:15]} context:nil].size.height;
    }
    _rowHeight += 40 + margin;
    return _rowHeight;
}

@end
