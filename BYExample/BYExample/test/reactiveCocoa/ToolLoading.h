//
//  ToolLoading.h
//  BYExample
//
//  Created by 付宝阳 on 2017/9/13.
//  Copyright © 2017年 付宝阳. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@protocol ToolLoadingDelegate
- (void)func;
@end

@interface ToolLoading : NSObject <UITableViewDelegate>

@property (nonatomic, assign) BOOL isLoading;
@property (nonatomic, strong) UIViewController *controller;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, copy) NSString *title;
//@property ()

@property (nonatomic, weak) id<ToolLoadingDelegate> delegate;
- (instancetype)initWith:(UIViewController *)controller tableView:(UITableView *)tableView;
- (void)start;
- (void)cancel;
@end
