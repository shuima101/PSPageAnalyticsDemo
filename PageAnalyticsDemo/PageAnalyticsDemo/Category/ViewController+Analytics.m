//
//  BaseViewController+Analytics.m
//  HYBmerchant
//
//  Created by 冯广勇 on 2017/9/7.
//  Copyright © 2017年 HYBiOS. All rights reserved.
//

#import "ViewController+Analytics.h"
#include "AnalyticsTool.h"

@implementation ViewController (Analytics)

+(void)load
{
    analytics_swizzleMethod([self class], @selector(viewDidAppear:), @selector(analytics_viewDidAppear:));
    analytics_swizzleMethod([self class], @selector(viewDidDisappear:), @selector(analytics_viewDidDisappear:));
}

-(void)analytics_viewDidAppear:(BOOL)animated
{
    [self analytics_viewDidAppear:animated];
    NSString *pageName = [self analytics_identification];
    NSLog(@"--- START: %@ ---", pageName);
}

-(void)analytics_viewDidDisappear:(BOOL)animated
{
    [self analytics_viewDidDisappear:animated];
    NSString *pageName = [self analytics_identification];
    NSLog(@"--- STOP: %@ ---", pageName);
}

-(NSString *)analytics_identification
{
    NSString *pageName = self.navigationItem.title;
    if (!pageName) {
        pageName = NSStringFromClass([self class]);
    }
    return pageName;
}

@end
