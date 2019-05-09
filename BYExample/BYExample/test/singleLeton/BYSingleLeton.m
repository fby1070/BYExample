//
//  BYSingleLeton.m
//  BYExample
//
//  Created by 付宝阳 on 2017/5/4.
//  Copyright © 2017年 付宝阳. All rights reserved.
//

#import "BYSingleLeton.h"

@implementation BYSingleLeton

static BYSingleLeton * instance = nil;

+ (instancetype)sharedSingleLeton {
    
    //dispatch_once是线程安全的，token默认为是0
    static dispatch_once_t token;
    
    //dispatch_once宏可以保证代码块中的指令只被执行一次
    dispatch_once(&token, ^{
        if (!instance) {
            instance = [[super allocWithZone:NULL] init];
        }
    });
    return instance;
}


//所有兑现内存空间的分配，最终都会调用allocWithZone
//如果要做单利，需要重写此方法
+ (id) allocWithZone:(struct _NSZone *)zone {
    return [self sharedSingleLeton];
}


- (id)copyWithZone:(NSZone *)zone {
    return self;
}

@end
