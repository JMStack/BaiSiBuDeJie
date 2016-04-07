//
//  NSFileManager+DeleteFilePath.h
//  BuDeJie
//
//  Created by Jack.Ma on 16/4/7.
//  Copyright © 2016年 Jack.Ma. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSFileManager (DeleteFilePath)

- (NSUInteger)totalSizeOfFileDirectory:(NSString *)path;
- (void)removeAllItemsOfFileDirectory:(NSString *)path;
@end
