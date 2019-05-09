//
//  BYStudent.m
//  BYExample
//
//  Created by 付宝阳 on 2018/1/7.
//  Copyright © 2018年 付宝阳. All rights reserved.
//

#import "BYStudent.h"

@implementation BYStudent

- (void)encodeWithCoder:(NSCoder *)aCoder {
  [aCoder encodeObject:_name forKey:@"name"];
  [aCoder encodeInteger:_age forKey:@"age"];
}

- (nullable instancetype)initWithCoder:(nonnull NSCoder *)aDecoder {
  if (self = [super init]) {
    self.name = [aDecoder decodeObjectForKey:@"name"];
    self.age = [aDecoder decodeIntegerForKey:@"age"];
  }
  return self;
}


@end
