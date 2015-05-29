//
//  MDLayout.h
//  MDLayout
//
//  Created by Jayden Zhao on 15/5/25.
//  Copyright (c) 2015年 jayden. All rights reserved.
//

@interface MDLayout : NSObject
+ (void)setLocationBundle:(NSBundle *)bundle;
+ (UIView *)loadViewWithFileName:(NSString *)fileName withSuperView:(UIView *)superView andHost:(id)host;
@end
