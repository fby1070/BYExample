//
//  BYTestViewViewController.m
//  BYExample
//
//  Created by 付宝阳 on 2017/6/22.
//  Copyright © 2017年 付宝阳. All rights reserved.
//

#import "BYTestViewViewController.h"
#import "Masonry.h"

@interface BYTestViewViewController ()

@end

@implementation BYTestViewViewController {
    UIView *imageView;
    UIView *view;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
//    UIView *sonView = [[UIView alloc] initWithFrame:CGRectMake(50, 50, 200, 200)];
//    sonView.backgroundColor = [UIColor blueColor];
//    [self.view addSubview:sonView];
//    
//    UIView *sonsonView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
////    sonsonView.bounds = CGRectMake(0, 0, 150, 150);
//    NSLog(@"%f",sonsonView.bounds.origin.x);
//    NSLog(@"%f",sonsonView.bounds.origin.y);
//    NSLog(@"%f",sonsonView.frame.origin.x);
//    NSLog(@"%f",sonsonView.frame.origin.y);
//
//    sonsonView.backgroundColor = [UIColor greenColor];
//    [sonView addSubview:sonsonView];
    
//    UIView *view = [[UIView alloc] init];
//    view.backgroundColor = [UIColor blueColor];
//    [self.view addSubview:view];
    
//    [view mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.center.equalTo(self.view);
//        make.size.mas_equalTo(CGSizeMake(100, 100));
//    }];
//    [view mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.mas_offset(UIEdgeInsetsMake(10, 10, 10, 10));
//    }];
    
    view = [[UIView alloc] init];
    view.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:view];

    imageView = [[UIView alloc] init];
    imageView.backgroundColor = [UIColor redColor];
    [view addSubview:imageView];
    
    UILabel *label = [[UILabel alloc] init];
    label.text = @"123123112313123123131231231";
    [view addSubview:label];
    
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.height.mas_equalTo(100);
        
    }];
    
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(view);
        make.left.equalTo(view.mas_left).offset(10);
        make.width.height.mas_equalTo(50);
        
    }];
    
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(imageView.mas_right).offset(10);
        make.right.equalTo(view.mas_right).offset(-10);
        make.centerY.equalTo(imageView);
    }];
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(200, 200, 100, 50)];
    [button setTitle:@"改变" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.view addSubview:button];
    [button addTarget:self action:@selector(change) forControlEvents:UIControlEventTouchUpInside];
    
}
- (void) change {
    
    [imageView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view.mas_left).offset(10);
        make.width.height.mas_equalTo(100);
    }];
    
}
@end
