//
//  BYCoreAnimationViewController.m
//  BYExample
//
//  Created by 付宝阳 on 2017/6/14.
//  Copyright © 2017年 付宝阳. All rights reserved.
//

#import "BYCoreAnimationViewController.h"
#import "BYAnimationView.h"

@interface BYCoreAnimationViewController ()

@property (nonatomic, strong) BYAnimationView *animationView;

@end

@implementation BYCoreAnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    _animationView = [[BYAnimationView alloc] initWithFrame:CGRectMake(0, 150, self.view.bounds.size.width, 120)];
    [self.view addSubview:_animationView];
    
    UIButton *startButton = [[UIButton alloc] initWithFrame:CGRectMake(20, 20, 80, 40)];
    [startButton addTarget:self action:@selector(startAnimation) forControlEvents:UIControlEventTouchUpInside];
    [startButton setTitle:@"开始" forState:UIControlStateNormal];
    startButton.backgroundColor = [UIColor redColor];
    [self.view addSubview:startButton];
}

- (void)startAnimation {
    [_animationView startAnimation];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
