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
+(UIView *)loadViewWithXMLElement:(RXMLElement *)element superView:(UIView *)superView andHost:(id)host{
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
            UIView *currentView = [[viewClass alloc] init];
            if (!host) {
                host = currentView;
            }
            currentView.host = host;
            NSArray *names = e.attributeNames;
            NSString *viewId = [e attribute:@"id"];
            for (NSString *attrName in names) {
                if ([attrName isEqualToString:@"id"]) {
                    [currentView applyValue:@([viewId hash]) withKey:@"tag"];
                    [currentView applyValue:viewId withKey:@"mid"];
                }else if ([attrName isEqualToString:@"style"]){
                    
                }else if([attrName isEqualToString:@"mdoutlet"]){
                    [host setValue:currentView forKey:viewId];
                }else{
                    [currentView applyValue:[e attribute:attrName] withKey:attrName];
                }
            }
            UIView *view = [self loadViewWithXMLElement:e superView:currentView andHost:host];
            if (superView) {
                [superView addSubview:view];
                
            }else{
                superView = view;
            }
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
