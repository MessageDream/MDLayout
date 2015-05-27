//
//  UIButton+MDExtensions.m
//  MDLayout
//
//  Created by jayden on 15/5/27.
//  Copyright (c) 2015年 jayden. All rights reserved.
//

#import "UIButton+MDExtensions.h"
#import <objc/runtime.h>

const char* const imageforNormalStateId = "imageforNormalStateId";
const char* const imageforSelectedStateId = "imageforSelectedStateId";
const char* const titleforNormalStateId = "titleforNormalStateId";
const char* const titleforSelectedStateId = "titleforSelectedStateId";
@implementation UIButton (MDExtensions)


-(void)setImageforNormalState:(UIImage *)imageforNormalState{
//    objc_setAssociatedObject(self, imageforNormalStateId, imageforNormalState, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self setImage:imageforNormalState forState:UIControlStateNormal];
}

-(UIImage *)imageforNormalState{
    return [self imageForState:UIControlStateNormal];
}

-(void)setImageforSelectedState:(UIImage *)imageforSelectedState{
//    objc_setAssociatedObject(self, imageforSelectedStateId, imageforSelectedState, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self setImage:imageforSelectedState forState:UIControlStateSelected];
}

-(UIImage *)imageforSelectedState{
    return [self imageForState:UIControlStateSelected];
}

-(void)setTitleforNormalState:(NSString *)titleforNormalState{
    [self setTitle:titleforNormalState forState:UIControlStateNormal];
//     [self setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
}

-(NSString *)titleforNormalState{
    return [self titleForState:UIControlStateNormal];
}

-(void)setTitleforSelectedState:(NSString *)titleforSelectedState{
    [self setTitle:titleforSelectedState forState:UIControlStateSelected];
//    [self setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
}

-(NSString *)titleforSelectedState{
    return [self titleForState:UIControlStateSelected];
}
@end
