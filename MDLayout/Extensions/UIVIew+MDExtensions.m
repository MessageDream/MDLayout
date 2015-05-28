//
//  UIVIew+MDExtensions.m
//  MDLayout
//
//  Created by Jayden Zhao on 15/5/27.
//  Copyright (c) 2015年 jayden. All rights reserved.
//

#import "UIView+MDExtensions.h"
#import "UIColor+MDExtensions.h"
#import "MDStyle.h"
#import <objc/runtime.h>

const char*  const mdConstraintsId = "mdConstraintsId";
const char*  const hostId = "hostId";
const char*  const mId = "mId";
@implementation UIView (MDExtensions)
-(void)setMdConstraints:(MDConstraints *)mdConstraints{
    objc_setAssociatedObject(self,mdConstraintsId , mdConstraints,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(MDConstraints *)mdConstraints{
    return objc_getAssociatedObject(self, mdConstraintsId);
}

-(void)setMid:(NSString *)mid{
     objc_setAssociatedObject(self,mId, mid,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(NSString *)mid{
    return objc_getAssociatedObject(self, mId);
}

-(void)setHost:(id)host{
    objc_setAssociatedObject(self,hostId, host,OBJC_ASSOCIATION_ASSIGN);
}

-(id)host{
    return objc_getAssociatedObject(self, hostId);
}

-(void)applyStyle:(MDStyle *)style{
    for (MDStyleItem *styleItem in style.styleArray) {
        id value = styleItem.styleValue;
        if([styleItem.styleProperty containsString:@"Color"]){
            value = [UIColor colorFromString:value];
        }
        if ([styleItem.styleProperty containsString:@"."]) {
            [self setValue:value forKeyPath:styleItem.styleProperty];
        }else{
            [self setValue:value forKey:styleItem.styleProperty];
        }
    }
}
@end
