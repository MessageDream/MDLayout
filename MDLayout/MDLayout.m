//
//  MDLayout.m
//  MDLayout
//
//  Created by Jayden Zhao on 15/5/25.
//  Copyright (c) 2015年 jayden. All rights reserved.
//

#import "MDLayout.h"
#import "MDLayoutConfig.h"
#import "MDLayoutContext.h"

@implementation MDLayout

+ (void)setLocationBundle:(NSBundle *)bundle{
    [[MDLayoutConfig share] setXmlBundle:bundle];
}

+(UIView *)loadViewWithFileName:(NSString *)fileName withSuperView:(UIView *)superView andHost:(id)host{
    if (!fileName) {
        return nil;
    }
    NSString *xmlPath = [[[MDLayoutConfig share].xmlBundle bundlePath] stringByAppendingPathComponent:fileName];
    MDLayoutContext *context = [[MDLayoutContext alloc] initWithXmlPath:xmlPath superView:superView andHost:host];
    return [context createView];
}
@end
