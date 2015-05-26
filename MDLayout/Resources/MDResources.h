//
//  MDResources.h
//  MDLayout
//
//  Created by Jayden Zhao on 15/5/26.
//  Copyright (c) 2015年 jayden. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MDStyle.h"
#import "MDData.h"

@interface MDResources : NSObject
@property(nonatomic,strong)MDStylesheet *styleSheet;
@property(nonatomic,strong)MDData *data;
@end
