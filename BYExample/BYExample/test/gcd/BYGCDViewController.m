//
//  BYGCDViewController.m
//  BYExample
//
//  Created by 付宝阳 on 2017/5/10.
//  Copyright © 2017年 付宝阳. All rights reserved.
//


//NSOprationQueue 与 GCD 的区别与选用
/*
 1.GCD是底层的C语言构成的API，而NSOperationQueue及相关对象是Objc的对象。在GCD中，在队列中执行的是由block构成的任务，这是一个轻量级的数据结构；而Operation作为一个对象，为我们提供了更多的选择；
 2.在NSOperationQueue中，我们可以随时取消已经设定要准备执行的任务(当然，已经开始的任务就无法阻止了)，而GCD没法停止已经加入queue的block(其实是有的，但需要许多复杂的代码)；
 3.NSOperation能够方便地设置依赖关系，我们可以让一个Operation依赖于另一个Operation，这样的话尽管两个Operation处于同一个并行队列中，但前者会直到后者执行完毕后再执行；
 4.我们能将KVO应用在NSOperation中，可以监听一个Operation是否完成或取消，这样子能比GCD更加有效地掌控我们执行的后台任务；
 5.在NSOperation中，我们能够设置NSOperation的priority优先级，能够使同一个并行队列中的任务区分先后地执行，而在GCD中，我们只能区分不同任务队列的优先级，如果要区分block任务的优先级，也需要大量的复杂代码；
 6.我们能够对NSOperation进行继承，在这之上添加成员变量与成员方法，提高整个代码的复用度，这比简单地将block任务排入执行队列更有自由度，能够在其之上添加更多自定制的功能。
    总的来说，Operation queue 提供了更多你在编写多线程程序时需要的功能，并隐藏了许多线程调度，线程取消与线程优先级的复杂代码，为我们提供简单的API入口。从编程原则来说，一般我们需要尽可能的使用高等级、封装完美的API，在必须时才使用底层API。但是我认为当我们的需求能够以更简单的底层代码完成的时候，简洁的GCD或许是个更好的选择，而Operation queue 为我们提供能更多的选择。
 */

#import "BYGCDViewController.h"

//gcd多线程
@interface BYGCDViewController ()

@end

@implementation BYGCDViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self barrier];
    
}








//dispatch_apply

- (void) apply {
    dispatch_queue_t queue = dispatch_get_main_queue();
    /*! dispatch_apply函数说明
     *
     *  @brief  dispatch_apply函数是dispatch_sync函数和Dispatch Group的关联API
     *         该函数按指定的次数将指定的Block追加到指定的Dispatch Queue中,并等到全部的处理执行结束
     *
     *  @param 10    指定重复次数  指定10次
     *  @param queue 追加对象的Dispatch Queue
     *  @param index 带有参数的Block, index的作用是为了按执行的顺序区分各个Block
     *
     */
    dispatch_apply(10, queue, ^(size_t index) {
        NSLog(@"%ld",index);
    });
    NSLog(@"done");
}
//dispatch_barrier_async 等待之前任务执行完在执行
- (void)barrier {
    dispatch_queue_t queue = dispatch_queue_create("com.bjsxt.barrierExecute", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(queue, ^{
        [NSThread sleepForTimeInterval:4];
        NSLog(@"1");
    });
    dispatch_async(queue, ^{
        [NSThread sleepForTimeInterval:4];
        NSLog(@"2");
    });
    dispatch_barrier_async(queue, ^{
        NSLog(@"3");
        [NSThread sleepForTimeInterval:4];
        
    });
    dispatch_async(queue, ^{
        [NSThread sleepForTimeInterval:1];
        NSLog(@"4");
    });
    
    dispatch_apply(10, queue, ^(size_t index) {
        NSLog(@"%ld",index);
    });
    NSLog(@"done");
}

//gcd延时加载，不卡主线程
- (void)delay {
    double delayInSeconds = 3.0;
    dispatch_queue_t mainQueue = dispatch_get_main_queue();
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds* NSEC_PER_SEC);
    dispatch_after(popTime, mainQueue, ^{
       NSLog(@"延时执行的3秒");
    });
}

- (void)testDemo {
    dispatch_queue_t concurrentQueue = dispatch_queue_create("com.bjsxt.concurrentQueue", DISPATCH_QUEUE_CONCURRENT);
    
    dispatch_async(concurrentQueue, ^{
        NSLog(@"4");
        dispatch_sync(concurrentQueue, ^{
            [NSThread sleepForTimeInterval:3];
            NSLog(@"5");
        });
        NSLog(@"6");
    });
}

//串行
- (void)gcdDemo1 {
    // 将操作放在队列中
    // 在C语言函数中，定义类型，绝大多数的结尾是_t或ref
    // 使用串行队列，的异步任务非常非常有用！新建子线程是有开销的，不能无休止新建线程，
    // 既可以保证效率（新建一个子线程），又能够保证并发
    dispatch_queue_t queue = dispatch_queue_create("queue1", DISPATCH_QUEUE_SERIAL);
    for (int i = 0; i < 10; i ++) {
        //同步任务
        dispatch_sync(queue, ^{
            NSLog(@"%@ ===%d",[NSThread currentThread],i);
        });
    }
    
    for (int i = 0; i < 10; i ++) {
        //异步任务
        dispatch_async(queue, ^{
            NSLog(@"%@ ===%d",[NSThread currentThread],i);
        });
    }
}

//并行
- (void)gcdDemo2 {
    
    // 特点：没有队形，执行顺序程序员不能控制
    // 应用场景：并发执行任务，没有先后顺序关系
    // 并行队列容易出错！并行队列不能控制新建线程数量！
    dispatch_queue_t queue = dispatch_queue_create("queue2", DISPATCH_QUEUE_CONCURRENT);
    
    
    for (int i = 0; i < 10 ; i ++) {
        //同步任务
        dispatch_sync(queue, ^{
            NSLog(@"%@ ===%d",[NSThread currentThread], i);
        });
    }
    
    for (int i = 0; i < 10; i ++) {
        //异步任务
        dispatch_async(queue, ^{
            NSLog(@"%@ ===%d", [NSThread currentThread], i);
        });
    }
    
}

// 全局队列 （苹果为了方便多线程的设计，提供一个全局队列，提供所有的APP共同使用）
- (void)gcdDemo3 {
    dispatch_queue_t queue= dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    for (int i = 0; i < 10 ; i ++) {
        //同步任务
        dispatch_sync(queue, ^{
            NSLog(@"%@ ===%d",[NSThread currentThread], i);
        });
    }
    
    for (int i = 0; i < 10; i ++) {
        //异步任务
        dispatch_async(queue, ^{
            NSLog(@"%@ ===%d", [NSThread currentThread], i);
        });
    }
}

// 主队列，保证操作在主线程上执行
- (void)gcdDemo4 {
    
    // 每一个应用程序都只有一个主线程
    dispatch_queue_t queue = dispatch_get_main_queue();
    
    // 主线程是一直都在工作的，除非将程序杀掉
    // 阻塞了！！！log不会打印
//    dispatch_sync(queue, ^{
//        NSLog(@"come here");
//    });
    
    // 异步任务，在主线程上运行，同时是保持队形的
    for (int i = 0; i < 10 ; i ++) {
        dispatch_async(queue, ^{
           NSLog(@"%@ ===%d", [NSThread currentThread], i);
        });
    }
}

- (IBAction):(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
