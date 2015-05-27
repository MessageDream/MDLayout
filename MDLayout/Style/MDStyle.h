//
//  Style.h
//  MDLayout
//
//  Created by jayden on 15/5/25.
//  Copyright (c) 2015年 jayden. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RXMLElement.h"

@interface MDStyleItem : NSObject
@property(nonatomic,strong)NSString *styleProperty;
@property(nonatomic,strong)NSString *styleValue;
@end

@interface MDStyle : NSObject
@property(nonatomic,strong)NSString *name;
@property(nonatomic,strong)NSString *target;
@property(nonatomic,strong)NSMutableArray *styleArray;
+ (MDStyle *)readStylesFromXMLElement:(RXMLElement *)element;
+ (MDStyle *)readStylesFromXMLFile:(NSString *)filename;
@end

@interface MDStylesheet : NSObject
@property(nonatomic,strong)NSString *styleRef;
@property(nonatomic,strong)NSMutableDictionary *targetStyleSheet;
@property(nonatomic,strong)NSMutableDictionary *styleSheet;
- (void)loadStyleFromStyleFile:(NSString *)fullPath;
+ (MDStylesheet *)readStyleSheetFromXMLElement:(RXMLElement *)element;
@end
