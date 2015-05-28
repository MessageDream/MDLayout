//
//  MDLayout.h
//  MDLayout
//
//  Created by Jayden Zhao on 15/5/25.
//  Copyright (c) 2015年 jayden. All rights reserved.
//

#import <Foundation/Foundation.h>
#import<UIKit/UIKit.h>
#import "RXMLElement.h"

@interface MDLayoutInfo : NSObject
@property(nonatomic,strong)UIView *parentView;
@property(nonatomic,strong)NSMutableDictionary *viewInfo;
@property(nonatomic,strong)NSMutableArray *constraintsInfo;
+(UIView *)loadViewWithXMLElement:(RXMLElement *)element superView:(UIView *)superView andHost:(id)host;
@end
