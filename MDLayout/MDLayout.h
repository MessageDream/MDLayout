//
//  MDLayout.h
//  MDLayout
//
//  Created by Jayden Zhao on 15/5/25.
//  Copyright (c) 2015年 jayden. All rights reserved.
//

#import <Foundation/Foundation.h>
#import<UIKit/UIKit.h>

@interface MDLayout : NSObject
+ (void)setLocationBundle:(NSBundle *)bundle;
+ (UIView *)loadViewWithFileName:(NSString *)fileName withSuperView:(UIView *)superView andHost:(id)host;
@end
