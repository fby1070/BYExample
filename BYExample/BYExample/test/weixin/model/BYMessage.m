//
//  BYMessage.m
//  BYExample
//
//  Created by 付宝阳 on 2017/5/19.
//  Copyright © 2017年 付宝阳. All rights reserved.
//

#import "BYMessage.h"

@implementation BYMessage

+ (instancetype)messageWithDict:(NSDictionary *)dict {
    return [[self alloc] initWithDict:dict];
}

- (instancetype)initWithDict:(NSDictionary *)dict {
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return  self;
}
@end
