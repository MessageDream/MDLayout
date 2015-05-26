//
//  MDLayout.m
//  MDLayout
//
//  Created by Jayden Zhao on 15/5/25.
//  Copyright (c) 2015年 jayden. All rights reserved.
//

#import "MDLayout.h"
#import "UIColor+Extensions.h"

@implementation MDLayoutInfo
+(UIView *)loadViewWithXMLElement:(RXMLElement *)element andSuperView:(UIView *)superView{
    NSString *eName = element.tag;
    for (RXMLElement *e in [element children]) {
         NSString *ename = e.tag;
        if([ename isEqualToString:@"Constraints"]){
            return superView;
        }else{
            Class viewClass = NSClassFromString(ename);
//            if ([viewClass] || [viewClass isKindOfClass: [UIView class]]) {
//                MDLayoutInfo *layout = [[MDLayoutInfo alloc] init];
//                layout.parentView = view;
            UIView *curView = [[viewClass alloc] init];
            NSArray *names = e.attributeNames;
            for (NSString *attrName in names) {
                if ([attrName isEqualToString:@"id"]) {
                    
                }else if ([attrName isEqualToString:@"style"]){
                
                }else{
                    id value = [e attribute:attrName];
                   if([attrName containsString:@"Color"]){
                       value = [UIColor colorFromString:[value stringValue]];
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
                    return superView;
                }
                return view;
//            }
        }
    }
    return nil;
}
@end
