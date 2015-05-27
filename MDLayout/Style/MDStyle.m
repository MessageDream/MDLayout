//
//  Style.m
//  MDLayout
//
//  Created by jayden on 15/5/25.
//  Copyright (c) 2015年 jayden. All rights reserved.
//

#import "MDStyle.h"
#import "MDLayoutConfig.h"

@implementation MDStyleItem

@end

@implementation MDStyle
+ (MDStyle *)readStylesFromXMLElement:(RXMLElement *)element{
    __block MDStyle* style =[[MDStyle alloc] init];
    style.name = [element attribute:@"name"];
    style.target = [element attribute:@"target"];
    [element iterate:@"Setter" usingBlock:^(RXMLElement *e) {
        MDStyleItem *item = [[MDStyleItem alloc] init];
        item.styleProperty = [e attribute:@"property"];
        item.styleValue = [e attribute:@"value"];
        if (!style.styleArray){
            style.styleArray = [NSMutableArray array];
        }
        [style.styleArray addObject:item];
    }];
    return style;
}
+ (MDStyle *)readStylesFromXMLFile:(NSString *)filename{
    return nil;
}
@end

@implementation MDStylesheet
-(void)loadStyleFromStyleFile:(NSString*)fullPath{
   RXMLElement *element = [[RXMLElement alloc] initFromXMLData:[NSData dataWithContentsOfFile:fullPath]];
    if (element) {
        __weak __typeof(self) weakSelf = self;
        [element iterate:@"Style" usingBlock:^(RXMLElement *e) {
            __strong __typeof(weakSelf) strongSelf = weakSelf;
            MDStyle *style = [MDStyle readStylesFromXMLElement:e];
            if (!strongSelf.styleSheet){
                strongSelf.styleSheet = [NSMutableDictionary dictionary];
            }
            if (!strongSelf.targetStyleSheet) {
                 strongSelf.targetStyleSheet = [NSMutableDictionary dictionary];
            }
            if (style.target) {
                [strongSelf.targetStyleSheet setObject:style forKey:style.target];
            }
            [strongSelf.styleSheet setObject:style forKey:style.name];
        }];
    }
}
+(MDStylesheet *)readStyleSheetFromXMLElement:(RXMLElement *)element{
    __block MDStylesheet* styleSheet =[[MDStylesheet alloc] init];
    styleSheet.styleRef = [[element child:@"Stylesheet"] attribute:@"ref"];
    if (styleSheet.styleRef) {
    
       NSString *refPath = [[[MDLayoutConfig share].xmlBundle bundlePath] stringByAppendingPathComponent:styleSheet.styleRef];
        [styleSheet loadStyleFromStyleFile:refPath];
    }
    [element iterate:@"Stylesheet.Style" usingBlock:^(RXMLElement *e) {
        MDStyle *style = [MDStyle readStylesFromXMLElement:e];
        if (!styleSheet.styleSheet){
           styleSheet.styleSheet = [NSMutableDictionary dictionary];
        }
        if (!styleSheet.targetStyleSheet) {
            styleSheet.targetStyleSheet = [NSMutableDictionary dictionary];
        }
        if (style.target) {
            [styleSheet.targetStyleSheet setObject:style forKey:style.target];
        }
        [styleSheet.styleSheet setObject:style forKey:style.name];
    }];
    return styleSheet;
}
@end
