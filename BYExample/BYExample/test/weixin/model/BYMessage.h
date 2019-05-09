//
//  BYMessage.h
//  BYExample
//
//  Created by 付宝阳 on 2017/5/19.
//  Copyright © 2017年 付宝阳. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSInteger {
    BYMessageMySelf,
    BYMessageOther,
}BYMessageType;

@interface BYMessage : NSObject

@property (nonatomic, copy) NSString *imageName;

@property (nonatomic, copy) NSString *message;

@property (nonatomic, assign) BYMessageType type;

+ (instancetype)messageWithDict:(NSDictionary *)dict;
- (instancetype)initWithDict:(NSDictionary *)dict;

@end

