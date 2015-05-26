//
//  MDLayoutConfig.m
//  MDLayout
//
//  Created by Jayden Zhao on 15/5/26.
//  Copyright (c) 2015年 jayden. All rights reserved.
//

#import "MDLayoutConfig.h"

@implementation MDLayoutConfig
-(NSBundle *)xmlBundle{
    if (!_xmlBundle) {
        _xmlBundle = [NSBundle mainBundle];
    }
    return _xmlBundle;
}
+(instancetype)share{
    static MDLayoutConfig *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance =[[self alloc] init];
    });
    return instance;
}
@end
