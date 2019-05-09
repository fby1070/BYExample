//
//  Person+CoreDataProperties.m
//  BYExample
//
//  Created by 付宝阳 on 2017/5/5.
//  Copyright © 2017年 付宝阳. All rights reserved.
//

#import "Person+CoreDataProperties.h"

@implementation Person (CoreDataProperties)

+ (NSFetchRequest<Person *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Person"];
}

@dynamic age;
@dynamic name;

@end
