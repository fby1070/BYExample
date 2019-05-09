//
//  BYLockViewController.m
//  BYExample
//
//  Created by 付宝阳 on 2017/6/28.
//  Copyright © 2017年 付宝阳. All rights reserved.
//

#import "BYLockViewController.h"
#import "pthread.h"

@interface BYLockViewController ()

@end

@implementation BYLockViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //1.自旋锁，OSSpinLock  速度最快，当资源被锁住时，会不断的循环查看资源有没有被释放，同时很消耗cpu，再停留时间较短的时候加自旋锁，但是因为容易发生优先级反转问题，所以被苹果禁用掉了，改成os_unfair_lock，解决了优先级反转问题。
    
    //2.信号量，dispatch_semaphore ,等待信号，发送信号，效率也很高，
    
    //3.pthread_mutex 锁，是一种非常易用的锁，只需要初始化pthread_mutex_t就可以直接加锁解锁操作，最后需要销毁（destory）；
    pthread_mutex_t lock;
    pthread_mutex_init(&lock, NULL);
    pthread_mutex_lock(&lock);
    //code
    pthread_mutex_unlock(&lock);
    
    //4.pthread_rwlock ,读写锁，适合读写的时候加锁，如果要用其他锁的话，再读的时候，其他锁也会禁止其他线程读的操作，而读写锁不会禁止。
    //    当读写锁被一个线程以读模式占用的时候，写操作的其他线程会被阻塞，读操作的其他线程还可以继续进行。
    //    当读写锁被一个线程以写模式占用的时候，写操作的其他线程会被阻塞，读操作的其他线程也被阻塞。
    pthread_rwlock_t rwlock = PTHREAD_RWLOCK_INITIALIZER;
    //读加锁
    pthread_rwlock_rdlock(&rwlock);
    //写加锁
    pthread_rwlock_wrlock(&rwlock);
    //读或写解锁
    pthread_rwlock_unlock(&rwlock);
    
    //5.条件锁，互斥锁配合条件使用，当判断的boolean变量为no的时候，条件等待，当锁执行完成后，发送信号，将boolean设为YES，等待的线程被唤醒
    
    
    //6.@synchronized 一个便捷的创建互斥锁的方式，它做了其他互斥锁所做的所有的事情。
    //如果你在不同的线程中传过去的是一样的标识符，先获得锁的会锁定代码块，另一个线程将被阻塞，如果传递的是不同的标识符，则不会造成线程阻塞。
    @synchronized (@"关键字") {
        
    }
    
    //7.NSLock 获得锁时候执行，没获得锁的挂起，知道锁释放。
    //但是连续操作两次会导致死锁，如果想递归操作的话，可以选择递归锁。
    NSLock *locklock = [[NSLock alloc] init];
    [locklock lock];
    //code
    [locklock unlock];
    
    //8.递归锁
    
    
    
}

- (void)lock {
    
}


@end
