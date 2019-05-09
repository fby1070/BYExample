//
//  ToolLoading.m
//  BYExample
//
//  Created by 付宝阳 on 2017/9/13.
//  Copyright © 2017年 付宝阳. All rights reserved.
//

#import "ToolLoading.h"

@implementation ToolLoading
- (instancetype)initWith:(UIViewController *)controller tableView:(UITableView *)tableView {
  if (self = [super init]) {
    self.controller = controller;
//    self.tableView = tableView;
    self.title = controller.title;
  }
  return self;
}

- (void)start {
//  self.tableView.delegate = self;
}

- (void)enable {
  self.controller.title = @"加载";
  NSLog(@"加入菊花");
}
- (void)cancel {
  self.controller.title = self.title;
  self.isLoading = NO;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
  NSLog(@"%f",self.tableView.contentOffset.y);
  if (!self.isLoading && self.tableView.contentOffset.y < - 320) {
    self.isLoading = YES;
    [self enable];
  }
}


@end
