//
//  UIFont+Extensions.h
//  MDLayout
//
//  Created by Jayden Zhao on 15/5/26.
//  Copyright (c) 2015年 jayden. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIFont (Extensions)

+ (void) registerCustomFonts;

+ (UIFont *) fontWithNameAndSize:(NSString *)nameAndSize;

@end
