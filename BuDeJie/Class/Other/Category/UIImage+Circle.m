//
//  UIImage+Circle.m
//  BuDeJie
//
//  Created by Jack.Ma on 16/4/6.
//  Copyright © 2016年 Jack.Ma. All rights reserved.
//

#import "UIImage+Circle.h"

@implementation UIImage (Circle)

- (UIImage *)circleImage {
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0);
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, self.size.width, self.size.height)];
    [path addClip];
    [self drawAtPoint:CGPointZero];
    UIImage *circelImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return circelImage;
}

@end
