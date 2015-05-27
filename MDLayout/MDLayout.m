//
//  MDLayout.m
//  MDLayout
//
//  Created by Jayden Zhao on 15/5/25.
//  Copyright (c) 2015年 jayden. All rights reserved.
//

#import "MDLayout.h"
#import "MDConstraint.h"
#import "UIVIew+MDExtensions.h"
#import "UIColor+MDExtensions.h"
#import "UIButton+MDExtensions.h"

@implementation MDLayoutInfo
+(UIView *)loadViewWithXMLElement:(RXMLElement *)element andSuperView:(UIView *)superView{
    //    NSString *eName = element.tag;
    for (RXMLElement *e in [element children]) {
        NSString *ename = e.tag;
        if([ename isEqualToString:@"Constraints"]){
            MDConstraints *constraints = [[MDConstraints alloc] initWithView:superView];
            [constraints loadConstraintsFromXMLElement:e];
            [superView setMdConstraints:constraints];
            continue;
        }else{
            Class viewClass = NSClassFromString(ename);
            //            if ([viewClass] || [viewClass isKindOfClass: [UIView class]]) {
            //                MDLayoutInfo *layout = [[MDLayoutInfo alloc] init];
            //                layout.parentView = view;
            UIView *curView = [[viewClass alloc] init];
            NSArray *names = e.attributeNames;
            for (NSString *attrName in names) {
                if ([attrName isEqualToString:@"id"]) {
                    [curView setValue:@([[e attribute:attrName] hash]) forKey:@"tag"];
                }else if ([attrName isEqualToString:@"style"]){
                    
                }else{
                    id value = [e attribute:attrName];
                    if([attrName containsString:@"Color"]){
                        value = [UIColor colorFromString:value];
                    }
                    if ([attrName containsString:@"."]) {
                        [curView setValue:value forKeyPath:attrName];
                    }else{
                        [curView setValue:value forKey:attrName];
                    }
                }
            }
            UIView *view = [self loadViewWithXMLElement:e andSuperView:curView];
            if (superView) {
                [superView addSubview:view];
                
            }else{
                superView = view;
            }
//            return view;
            //            }
        }
    }
    NSArray *subViews = superView.subviews;
    for (UIView *view in subViews) {
        [view.mdConstraints makeAndInstall];
    }
    return superView;
}
@end
