//
//  MDConstraint.h
//  MDLayout
//
//  Created by Jayden Zhao on 15/5/26.
//  Copyright (c) 2015年 jayden. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class MASConstraint,MASConstraintMaker,RXMLElement;

@interface MDConstraint : NSObject
@property(nonatomic,strong)NSString *attribute;
@property(nonatomic,strong)NSString *target;
@property(nonatomic,strong)NSString *targetAttribute;
@property(nonatomic,strong)NSString *relation;
@property(nonatomic,strong)NSString *multipliedBy;
@property(nonatomic,strong)id constant;
@property(nonatomic,strong)NSString *priority;
@property(nonatomic,strong)NSString *mid;
-(instancetype)initWithXMLElement:(RXMLElement *)element;
-(MASConstraint *)converteMasConstraintWithConstraintMaker:(MASConstraintMaker *)make;
@end

@interface MDConstraints : NSObject
{
    MASConstraintMaker *_make;
}
@property(nonatomic,weak)UIView *view;
@property(nonatomic,strong)NSMutableArray *constraints;
@property(nonatomic,strong,readonly)MASConstraintMaker *constraintMaker;
-(instancetype)initWithView:(UIView *)view;
-(void)makeConstraints;
-(void)makeAndInstall;
-(void)loadConstraintsFromXMLElement:(RXMLElement *)element;
@end
