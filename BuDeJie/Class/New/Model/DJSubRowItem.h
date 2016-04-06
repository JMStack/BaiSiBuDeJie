//
//  DJSubRowItem.h
//  BuDeJie
//
//  Created by Jack.Ma on 16/4/5.
//  Copyright © 2016年 Jack.Ma. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DJSubRowItem : NSObject

@property (strong, nonatomic) NSString *image_list;
@property (assign, nonatomic) BOOL is_sub;
@property (assign, nonatomic) NSInteger sub_number;
@property (assign, nonatomic) NSInteger theme_id;
@property (strong, nonatomic) NSString *theme_name;

@end
