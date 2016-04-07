//
//  NSFileManager+DeleteFilePath.m
//  BuDeJie
//
//  Created by Jack.Ma on 16/4/7.
//  Copyright © 2016年 Jack.Ma. All rights reserved.
//

#import "NSFileManager+DeleteFilePath.h"

@implementation NSFileManager (DeleteFilePath)

- (NSUInteger)totalSizeOfFileDirectory:(NSString *)path {
    
    //获取文件夹下的子文件
    NSArray *subPaths = [self subpathsAtPath:path];
    NSUInteger size = 0;
    
    for (NSString *subPath in subPaths) {
        NSString *fullPath = [path stringByAppendingPathComponent:subPath];
        // 不计算文件夹的大小
        BOOL isDirectory =  NO;
        BOOL isExist = [self fileExistsAtPath:fullPath isDirectory:&isDirectory];
        if (isDirectory || !isExist) {
            continue;
        }
        NSDictionary *attributes = [self attributesOfItemAtPath:fullPath error:nil];
        NSString *fileSize = attributes[NSFileSize];
        size += fileSize.intValue;
    
    }
    return size;
}

- (void)removeAllItemsOfFileDirectory:(NSString *)path {
    
    //获取文件夹下的子文件
    NSArray *subPaths = [self contentsOfDirectoryAtPath:path error:nil];
    
    for (NSString *subPath in subPaths) {
        NSString *fullPath = [path stringByAppendingPathComponent:subPath];
        [self removeItemAtPath:fullPath error:nil];
    }
    
}

@end
