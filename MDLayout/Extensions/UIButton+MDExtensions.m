//
//  UIButton+MDExtensions.m
//  MDLayout
//
//  Created by jayden on 15/5/27.
//  Copyright (c) 2015年 jayden. All rights reserved.
//

#import "UIButton+MDExtensions.h"
#import "UIView+MDExtensions.h"
#import <objc/runtime.h>

const char* const clickActionId = "clickActionId";

@implementation UIButton (MDExtensions)


-(void)setImageforNormalState:(UIImage *)imageforNormalState{
    [self setImage:imageforNormalState forState:UIControlStateNormal];
}

-(UIImage *)imageforNormalState{
    return [self imageForState:UIControlStateNormal];
}

-(void)setImageforSelectedState:(UIImage *)imageforSelectedState{
    [self setImage:imageforSelectedState forState:UIControlStateSelected];
}

-(UIImage *)imageforSelectedState{
    return [self imageForState:UIControlStateSelected];
}

-(void)setTitleforNormalState:(NSString *)titleforNormalState{
    [self setTitle:titleforNormalState forState:UIControlStateNormal];
}

-(NSString *)titleforNormalState{
    return [self titleForState:UIControlStateNormal];
}

-(void)setTitleforSelectedState:(NSString *)titleforSelectedState{
    [self setTitle:titleforSelectedState forState:UIControlStateSelected];
}

-(NSString *)titleforSelectedState{
    return [self titleForState:UIControlStateSelected];
}

-(void)setClickAction:(NSString *)clickAction{
    if (self.host) {
        [self addTarget:self.host action:NSSelectorFromString(clickAction) forControlEvents:UIControlEventTouchUpInside];
    }
    objc_setAssociatedObject(self, clickActionId, clickAction, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(NSString *)clickAction{
    return objc_getAssociatedObject(self, clickActionId);
}
@end
