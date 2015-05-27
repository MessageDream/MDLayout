//
//  MDConstraint.m
//  MDLayout
//
//  Created by Jayden Zhao on 15/5/26.
//  Copyright (c) 2015年 jayden. All rights reserved.
//

#import "MDConstraint.h"
#import "Masonry.h"
#import "RXMLElement.h"
#import <objc/message.h>

@implementation MDConstraint
-(instancetype)initWithXMLElement:(RXMLElement *)element{
    if (self = [super init]) {
        self.cid = [element attribute:@"id"];
        self.attribute = [element attribute:@"attribute"];
        self.target =[element attribute:@"target"];
        self.targetAttribute = [element attribute:@"targetAttribute"];
        self.relation = [element attribute:@"relation"];
        self.multipliedBy = [element attribute:@"multipliedBy"];
        self.constant = [element attribute:@"constant"];
        self.priority = [element attribute:@"priority"];
    }
    return self;
}

-(void)setTargetAttribute:(NSString *)targetAttribute{
    if (!targetAttribute) {
        return;
    }
    _targetAttribute = [NSString stringWithFormat:@"mas_%@",targetAttribute];
}

-(void)setPriority:(NSString *)priority{
    if (!priority) {
        return;
    }
    if ([priority isEqualToString:@"high"]) {
        _priority = @"priorityHigh";
    }else if([priority isEqualToString:@"low"]){
        _priority = @"priorityLow";
    }else{
        _priority = @"priorityMedium";
    }
}

-(void)setConstant:(id)constant{
    if (!constant) {
        return;
    }
    
    if ([self.attribute isEqualToString:@"center"]){
        NSString *formatString = [NSString stringWithFormat:@"{%@}",constant];
        CGPoint actualPoint = CGPointFromString(formatString);
        _constant = [NSValue valueWithCGPoint:actualPoint];
        return;
    }
    
    if ([self.attribute isEqualToString:@"size"]){
        NSString *formatString = [NSString stringWithFormat:@"{%@}",constant];
         CGSize actualSize = CGSizeFromString(formatString);
        _constant = [NSValue valueWithCGSize:actualSize];
        return;
    }
    
    if ([self.attribute isEqualToString:@"edges"]){
        NSString *formatString = [NSString stringWithFormat:@"{%@}",constant];
        UIEdgeInsets actualInsets = UIEdgeInsetsFromString(formatString);
        _constant = [NSValue valueWithUIEdgeInsets:actualInsets];
        return;
    }
    
    float actualFloat = [constant floatValue];
    if (actualFloat > 0) {
        _constant = [NSNumber numberWithFloat:actualFloat];
    }
    
//    if (strcmp(type, @encode(float)) == 0) {
//        float actual = [constant floatValue];
//        _constant = [NSNumber numberWithFloat:actual];
//    }
//    if (strcmp(type, @encode(int)) == 0) {
//        int actual = [constant intValue];
//        _constant = [NSNumber numberWithInt:actual];
//    }
//    if (strcmp(type, @encode(long)) == 0) {
//        long actual = [constant longValue];
//        _constant = [NSNumber numberWithLong:actual];
//    }
}

-(void)setRelation:(NSString *)relation{
    if ([relation isEqualToString:@"<="]) {
        _relation = @"mas_lessThanOrEqualTo";
    }else if([relation isEqualToString:@">="]){
        _relation = @"mas_greaterThanOrEqualTo";
    }else{
        _relation = @"mas_equalTo";
    }
}

-(MASConstraint *)converteMasConstraintWithConstraintMaker:(MASConstraintMaker *)make{
    SEL attributeSelector = NSSelectorFromString(self.attribute);
    MASConstraint *currentAttributeConstraint = (( MASConstraint * (*)(id, SEL))objc_msgSend)(make, attributeSelector);
    SEL relationSelector = NSSelectorFromString([NSString stringWithFormat:@"%@",self.relation]);
    MASConstraint * (^relationBlock)(id)   = (( id (*)(id, SEL))objc_msgSend)(currentAttributeConstraint, relationSelector);
    UIView *view = [make valueForKey:@"view"];
    view.translatesAutoresizingMaskIntoConstraints = NO;
    if(self.target){
        UIView *superView =view.superview;
        UIView *targetView = [superView viewWithTag:[self.target hash]];
        BOOL isEdges = [self.attribute isEqualToString:@"edges"];
        if (self.targetAttribute) {
            //(obj.mas_)
            SEL targetAttributeSelector = NSSelectorFromString(self.targetAttribute);
            MASViewAttribute  *targetAttribute = (( MASViewAttribute  * (*)(id, SEL))objc_msgSend)(targetView, targetAttributeSelector);
            currentAttributeConstraint = relationBlock(targetAttribute);
        }else{
            //(obj)
            currentAttributeConstraint = relationBlock(targetView);
            //insets()
            if (isEdges) {
                SEL insetsSelector = NSSelectorFromString(@"insets");
                MASConstraint  * (^insetsBlock)(UIEdgeInsets) = (( id (*)(id, SEL))objc_msgSend)(currentAttributeConstraint, insetsSelector);
                currentAttributeConstraint = insetsBlock([self.constant UIEdgeInsetsValue]);
            }
        }
        
        if (!isEdges && self.constant) {
            SEL offsetSelector = NSSelectorFromString(@"offset");
            MASConstraint * (^offsetBlock)(CGFloat) = (( id (*)(id, SEL))objc_msgSend)(currentAttributeConstraint, offsetSelector);
            currentAttributeConstraint = offsetBlock([self.constant floatValue]);
        }
    }else{
        //(80)
        //(CGSizeMake(10.20))
        currentAttributeConstraint = relationBlock(self.constant);
    }
    
    //multipliedBy
    if (self.multipliedBy) {
        SEL multipliedBySelector = NSSelectorFromString(@"multipliedBy");
        MASConstraint * (^multipliedByBlock)(CGFloat) = (( id (*)(id, SEL))objc_msgSend)(currentAttributeConstraint, multipliedBySelector);
        currentAttributeConstraint = multipliedByBlock([self.multipliedBy floatValue]);
    }
    
    //priority
    if (self.priority) {
        SEL prioritySelector = NSSelectorFromString(self.priority);
        MASConstraint * (^priorityBlock)() = (( id (*)(id, SEL))objc_msgSend)(currentAttributeConstraint, prioritySelector);
        currentAttributeConstraint = priorityBlock();
    }
    return currentAttributeConstraint;
}

@end

@implementation MDConstraints
-(instancetype)initWithView:(UIView *)view{
    if (self = [super init]) {
        _view = view;
    }
    return self;
}

-(void)makeConstraints{
    for (MDConstraint *constraint in self.constraints) {
        [constraint converteMasConstraintWithConstraintMaker:self.constraintMaker];
    }
}

-(void)makeAndInstall{
    [self makeConstraints];
    [self.constraintMaker install];
}

-(MASConstraintMaker *)constraintMaker{
    if (!_make) {
       _make = [[MASConstraintMaker alloc] initWithView:_view];
    }
    return _make;
}

-(void)loadConstraintsFromXMLElement:(RXMLElement *)element{
    [element iterate:@"Constraint" usingBlock:^(RXMLElement *e) {
        if (!self.constraints) {
            self.constraints = [NSMutableArray array];
        }
        [self.constraints addObject:[[MDConstraint alloc]initWithXMLElement:e]];
    }];
}
@end