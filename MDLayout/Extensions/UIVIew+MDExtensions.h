//
//  UIVIew+MDExtensions.h
//  MDLayout
//
//  Created by Jayden Zhao on 15/5/27.
//  Copyright (c) 2015年 jayden. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class MDStyle,MDConstraints;
@interface UIView (MDExtensions)
@property(nonatomic,strong)MDConstraints *mdConstraints;
@property(nonatomic,strong)NSString *mid;
@property(nonatomic,weak)id host;
-(void)applyStyle:(MDStyle *)style;
-(void)applyValue:(id)value withKey:(NSString *)key;
@end
