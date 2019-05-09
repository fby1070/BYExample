//
//  BYSingleLeton.h
//  BYExample
//
//  Created by 付宝阳 on 2017/5/4.
//  Copyright © 2017年 付宝阳. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BYSingleLeton : NSObject<NSCopying>

+ (instancetype)sharedSingleLeton;

@end
