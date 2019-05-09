//
//  BYReactiveCocoaViewController.m
//  BYExample
//
//  Created by 付宝阳 on 2017/7/20.
//  Copyright © 2017年 付宝阳. All rights reserved.
//

#import "BYReactiveCocoaViewController.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "ToolLoading.h"

@interface BYReactiveCocoaViewController ()
//@property (strong, nonatomic) RACCommand *command;

@end

@implementation BYReactiveCocoaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(20, 20, 100, 40)];
    [backButton setTitle:@"返回" forState:UIControlStateNormal];
    [backButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self.view addSubview:backButton];
  
    [[backButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            [self dismissViewControllerAnimated:YES completion:nil];
    }];
  
  UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake((self.view.frame.size.width-100)/2, (self.view.frame.size.height-40) /2, 100, 40)];
  [button setTitle:@"command" forState:UIControlStateNormal];
  [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
  [button setBackgroundColor:[UIColor redColor]];
  [self.view addSubview:button];
  
  RACCommand *command =[[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
      [subscriber sendNext:@"123"];
      [subscriber sendNext:@"123"];
      [subscriber sendCompleted];
      return [RACDisposable disposableWithBlock:^{
        NSLog(@"Disposable");
      }];
    }];
  }];
  button.rac_command = command;
  
  [[command executing] subscribeNext:^(id x) {
    if ([x boolValue]) {
      NSLog(@"正在执行");
    } else {
      NSLog(@"执行结束");
    }
  }];
  
  [[command executionSignals] subscribeNext:^(RACSignal *x) {
    [x subscribeCompleted:^{
      NSLog(@"结束block");
    }];
    
    [x subscribeNext:^(id x) {
      NSLog(@"接受到的数据%@",x);
    }];
    
  }];
  
}
@end
