//
//  UIImage+MDExtensions.h
//  MDLayout
//
//  Created by Jayden Zhao on 15/5/26.
//  Copyright (c) 2015年 jayden. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (MDExtensions)

+ (UIImage *) imageWithColor:(UIColor *)color
	cornerRadius:(CGFloat)cornerRadius;

+ (UIImage *) buttonImageWithColor:(UIColor *)color
	cornerRadius:(CGFloat)cornerRadius
	shadowColor:(UIColor *)shadowColor
	shadowInsets:(UIEdgeInsets)shadowInsets;

- (UIImage *) imageWithMinimumSize:(CGSize)size;

+ (UIImage *) backButtonImageWithColor:(UIColor *)color
	barMetrics:(UIBarMetrics)metrics
	cornerRadius:(CGFloat)cornerRadius;

@end
