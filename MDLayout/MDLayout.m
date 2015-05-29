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
#import "MGTemplateEngine.h"
#import "ICUTemplateMatcher.h"

@implementation MDLayout

+ (void)setLocationBundle:(NSBundle *)bundle{
    [[MDLayoutConfig share] setXmlBundle:bundle];
}

+(UIView *)loadViewWithFileName:(NSString *)fileName withSuperView:(UIView *)superView andHost:(id)host{
    if (!fileName) {
        return nil;
    }
    NSString *xmlPath = [[[MDLayoutConfig share].xmlBundle bundlePath] stringByAppendingPathComponent:fileName];
    MGTemplateEngine *engine = [MGTemplateEngine templateEngine];
    [engine setMatcher:[ICUTemplateMatcher matcherWithTemplateEngine:engine]];
    [engine setObject:@"hello" forKey:@"title"];

    NSString *xmlContent = [engine processTemplateInFileAtPath:xmlPath withVariables:nil];
    MDLayoutContext *context = [[MDLayoutContext alloc] initWithXmlString:xmlContent superView:superView andHost:host];
    return [context createView];
}
@end
