//
//  BYNSOperationViewController.m
//  BYExample
//
//  Created by 付宝阳 on 2017/5/15.
//  Copyright © 2017年 付宝阳. All rights reserved.
//

#import "BYNSOperationViewController.h"


//多线程
@interface BYNSOperationViewController ()

@property (nonatomic, strong) NSOperationQueue *myQueue;

@end

@implementation BYNSOperationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.myQueue = [[NSOperationQueue alloc] init];
    [self demoOp1];
}


//线程分为两种锁，
//1.原子锁，atomic，只保护写入时的数据正常，不负责读取
//2.互斥锁，synchronized,保护读写，性能消耗非常大，苹果官方不建议使用（xcode无提示）

//在实际开发中，不要去抢夺资源！
//并发程序最主要的目的是提高性能，让更多代码同时运行，达到并发运行，提高整体性能的目的

//手机开发最主要的是流畅，并行，至于资源抢夺的功能开发是属于服务端的范畴

- (void)demo {
    NSBlockOperation *op1 = [NSBlockOperation blockOperationWithBlock:^{
       NSLog(@"下载图片  %@", [NSThread currentThread]);
    }];
    
    NSBlockOperation *op2 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"修饰图片  %@", [NSThread currentThread]);
    }];
    
    NSBlockOperation *op3 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"保存图片  %@", [NSThread currentThread]);
    }];
    
    NSBlockOperation *op4 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"更新UI  %@", [NSThread currentThread]);
    }];
    
    //设置顺序，Dependency依赖，可能会开多个，但不会太多
    //依赖关系是可以跨队列的
    [op2 addDependency:op1];
    [op3 addDependency:op2];
    [op4 addDependency:op3];
    //GCD是串行队列，异步任务，只会开一个线程
    
    [self.myQueue addOperation:op1];
    [self.myQueue addOperation:op2];
    [self.myQueue addOperation:op3];
//    [self.myQueue addOperation:op4];
    //所有UI的更新需要在主线程上进行
    [[NSOperationQueue mainQueue] addOperation:op4];
}


- (void)demoOp1 {
//    NSBlockOperation *block = [NSBlockOperation blockOperationWithBlock:^{
//        NSLog(@"%@", [NSThread currentThread]);
//    }];
//    
//    //所有的自定义队列，都是在子线程中执行
//    [self.myQueue addOperation:block];
//    
//    //在主线程中运行
//    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
//        NSLog(@"%@", [NSThread currentThread]);
//    }];
    
    //新建线程是有开销的
    //在设定同时，并发的最大线程数时，如果前一个线程工作完成，但是还没有销毁，会新建线程
    //应用场景：在网络开发中，下载工作！流量！（线程开销：CPU， MEM）电量！
    //如果是3G，开3个子线程
    //如果是WIFI，开6个子线程
    [_myQueue setMaxConcurrentOperationCount:1];
    for (int i = 0;  i < 10; i ++) {
        [_myQueue addOperationWithBlock:^{
            NSLog(@"%@ --- %d", [NSThread currentThread], i);
        }];
    }
}

- (void)demoOp2 {
    
    //定义一个方法，能够接受一个参数
    //是用起来啊不够灵活
    NSInvocationOperation *op = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(demo2Selector:) object:@"hello op"];
    
//    [self.myQueue addOperation:op];
    
    [[NSOperationQueue mainQueue] addOperation:op];
}


- (void)demo2Selector:(id)obj {
    NSLog(@"%@ ---%@ ", [NSThread currentThread], obj);
}

- (IBAction)goback:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
    
}


@end
