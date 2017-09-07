//
//  UIControl+Analytics.m
//  HYBmerchant
//
//  Created by 冯广勇 on 2017/9/7.
//  Copyright © 2017年 HYBiOS. All rights reserved.
//

#import "UIControl+Analytics.h"
#include "AnalyticsTool.h"

@implementation UIControl (Analytics)

+(void)load
{
    analytics_swizzleMethod([self class], @selector(sendAction:to:forEvent:), @selector(analytics_sendAction:to:forEvent:));
}

-(void)analytics_sendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event
{
    [self analytics_sendAction:action to:target forEvent:event];
    
    NSString *clsName = NSStringFromClass([target class]);
    NSString *methodName = NSStringFromSelector(action);
    NSString *name = [[NSString alloc] initWithFormat:@"%@_%@_%ld", clsName, methodName, (long)self.tag];
    NSLog(@"--- %@ ---", name);
}

@end
