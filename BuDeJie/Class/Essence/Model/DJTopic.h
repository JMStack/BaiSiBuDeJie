//
//  DJTopic.h
//  BuDeJie
//
//  Created by Jack.Ma on 16/4/14.
//  Copyright © 2016年 Jack.Ma. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DJTopic : NSObject

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *profile_image;
@property (strong, nonatomic) NSString *text;
@property (strong, nonatomic) NSString *type;
@property (strong, nonatomic) NSString *love;
@property (strong, nonatomic) NSString *hate;
@property (strong, nonatomic) NSString *comment;
@property (strong, nonatomic) NSString *repost;
@property (strong, nonatomic) NSArray *top_cmt;
@property (strong, nonatomic) NSString *passtime;


@property (assign, nonatomic) CGFloat rowHeight;

@end
