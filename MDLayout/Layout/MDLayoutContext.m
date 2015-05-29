//
//  MDLayoutContext.m
//  MDLayout
//
//  Created by Jayden Zhao on 15/5/28.
//  Copyright (c) 2015年 jayden. All rights reserved.
//

#import "MDLayoutContext.h"
#import "MDStyle.h"
#import "MDConstraint.h"
#import "UIVIew+MDExtensions.h"
#import "UIColor+MDExtensions.h"
#import "UIButton+MDExtensions.h"

@interface  MDLayoutContext()
+(UIView *)loadViewWithXMLElement:(RXMLElement *)element styleSheet:(MDStylesheet *)styleSheet superView:(UIView *)superView andHost:(id)host;
@end
@implementation MDLayoutContext
-(instancetype)initWithXmlPath:(NSString *)path superView:(UIView *)superView andHost:(id)host{
    if (self = [super init]) {
        self.xmlpath = path;
        self.superView = superView;
        self.host = host;
    }
    return self;
}
-(instancetype)initWithXmlString:(NSString *)string superView:(UIView *)superView andHost:(id)host{
    if (self = [super init]) {
        self.xmlString = string;
        self.superView = superView;
        self.host = host;
    }
    return self;
}

-(UIView *)createView{
    if (!self.xmlpath && !self.xmlString) {
        return nil;
    }
    RXMLElement *rootXML;
    if (self.xmlpath) {
        rootXML = [[RXMLElement alloc] initFromXMLFilePath:self.xmlpath];
    }else{
        rootXML = [[RXMLElement alloc] initFromXMLString:self.xmlString encoding:NSUTF8StringEncoding];
    }
   
    self.styleSheet = [MDStylesheet readStyleSheetFromXMLElement:[rootXML child:@"Resources"]];
    return [MDLayoutContext loadViewWithXMLElement:[rootXML child:@"Layout"] styleSheet:self.styleSheet superView:self.superView andHost:self.host];
}

+(UIView *)loadViewWithXMLElement:(RXMLElement *)element styleSheet:(MDStylesheet *)styleSheet superView:(UIView *)superView andHost:(id)host{
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
            
            //应用类样式
            MDStyle *style = styleSheet.targetStyleSheet[ename];
            if (style) {
                [currentView applyStyle:style];
            }
            
            //应用指定样式
            NSString *styleName= [e attribute:@"style"];
            if (styleName) {
                style = styleSheet.styleSheet[styleName];
                if (style) {
                    [currentView applyStyle:style];
                }
            }
            
            //应用属性
            for (NSString *attrName in names) {
                NSString *value = [e attribute:attrName];
                if ([attrName isEqualToString:@"style"]){
                    continue;
                }else if ([attrName isEqualToString:@"id"]) {
                    [currentView applyValue:@([viewId hash]) withKey:@"tag"];
                    [currentView applyValue:viewId withKey:@"mid"];
                }else if([attrName isEqualToString:@"mdoutlet"]){
                    [host setValue:currentView forKey:viewId];
                }else{
                    [currentView applyValue:value withKey:attrName];
                }
            }
            UIView *view = [self loadViewWithXMLElement:e styleSheet:styleSheet superView:currentView andHost:host];
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
