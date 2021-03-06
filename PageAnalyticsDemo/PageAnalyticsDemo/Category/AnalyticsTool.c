//
//  AnalyticsTool.c
//  HYBmerchant
//
//  Created by 冯广勇 on 2017/9/7.
//  Copyright © 2017年 HYBiOS. All rights reserved.
//

#include "AnalyticsTool.h"

void analytics_swizzleMethod(Class cls, SEL originSel, SEL swizzledSel)
{
    Method originMethod = class_getInstanceMethod(cls, originSel);
    Method swizzledMethod = class_getInstanceMethod(cls, swizzledSel);
    
    IMP swizzledImp = method_getImplementation(swizzledMethod);
    const char *types = method_getTypeEncoding(swizzledMethod);
    BOOL success = class_addMethod(cls, originSel, swizzledImp, types);
    // if-else 可以在子类没有实现 originSel的时候,避免替换父类的方法, 而对父类的其他子类产生影响(如果认为判断没有必要, 可以注释掉if判断, 只留下else里的语句试一下, 我设置了一个崩溃)
    if (success) {
        IMP originImp = method_getImplementation(originMethod);
        const char *types = method_getTypeEncoding(originMethod);
        class_replaceMethod(cls, swizzledSel, originImp, types);
    }else {
        method_exchangeImplementations(originMethod, swizzledMethod);
    }
}
