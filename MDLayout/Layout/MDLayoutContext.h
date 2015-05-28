//
//  MDLayoutContext.h
//  MDLayout
//
//  Created by Jayden Zhao on 15/5/28.
//  Copyright (c) 2015年 jayden. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class MDStylesheet;

@interface MDLayoutContext : NSObject
@property(nonatomic,strong)NSString *xmlpath;
@property(nonatomic,strong)MDStylesheet *styleSheet;
@property(nonatomic,strong)UIView *superView;
@property(nonatomic,strong)id host;
-(instancetype)initWithXmlPath:(NSString *)path superView:(UIView *)superView andHost:(id)host;
-(UIView *)createView;
@end
