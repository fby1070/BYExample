//
//  ViewController.m
//  BYExample
//
//  Created by 付宝阳 on 2017/5/4.
//  Copyright © 2017年 付宝阳. All rights reserved.
//

#import "ViewController.h"
#import "BYSingleLeton.h"
#import "Person+CoreDataClass.h"
#import "BYCoreDataViewContrller.h"
#import "BYSingleLetonViewController.h"
#import "BYGCDViewController.h"
#import "BYNSOperationViewController.h"
#import "BYChatViewController.h"
#import "BYSQLLiteViewController.h"
#import "BYCoreAnimationViewController.h"
#import "BYTestViewViewController.h"
#import <libkern/OSAtomic.h>
#import <os/lock.h>
#import <objc/runtime.h>
#import "BYReactiveCocoaViewController.h"
#import "TableViewPicViewController.h"
#import "BYStudent.h"
#import "BYOpenGLViewController.h"

@interface VedHomeModel : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *detail;
@property (nonatomic, assign) Class vcClass;

- (instancetype)initWithTitle:(NSString *)title vcClass:(Class)vcClass detail:(NSString *)detail;
@end

@implementation VedHomeModel

- (instancetype)initWithTitle:(NSString *)title vcClass:(Class)vcClass detail:(NSString *)detail {
    self = [super init];
    if (self) {
        self.title = title;
        self.detail = detail;
        self.vcClass = vcClass;
    }
    return self;
}
@end

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, copy) NSArray *itemArray;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.itemArray = @[[[VedHomeModel alloc] initWithTitle:@"View Test" vcClass:[BYTestViewViewController class] detail:@"布局测试"],
                       [[VedHomeModel alloc] initWithTitle:@"CoreData" vcClass:[BYCoreDataViewContrller class] detail:@"数据库基本操作"],
                       [[VedHomeModel alloc] initWithTitle:@"单例模式" vcClass:[BYSingleLetonViewController class] detail:@"单例写法以及要点"],
                       [[VedHomeModel alloc] initWithTitle:@"GCD线程" vcClass:[BYGCDViewController class] detail:@"GCD用法"],
                       [[VedHomeModel alloc] initWithTitle:@"NSOperation" vcClass:[BYNSOperationViewController class] detail:@"NSOperation用法"],
                       [[VedHomeModel alloc] initWithTitle:@"SQLite" vcClass:[BYSQLLiteViewController class] detail:@"SQLite基本用法"],
                       [[VedHomeModel alloc] initWithTitle:@"微信" vcClass:[BYChatViewController class] detail:@"模仿微信聊天界面"],
                       [[VedHomeModel alloc] initWithTitle:@"动画" vcClass:[BYCoreAnimationViewController class] detail:@"CoreAnimation"],
                       [[VedHomeModel alloc] initWithTitle:@"ReactiveCocoa" vcClass:[BYReactiveCocoaViewController class] detail:@"RAC使用方式"],
                       [[VedHomeModel alloc] initWithTitle:@"效果" vcClass:[TableViewPicViewController class] detail:@"列表头下拉放大"],
                       [[VedHomeModel alloc] initWithTitle:@"OpenGL" vcClass:[BYOpenGLViewController class] detail:@"OpenGL 练习"],
                       ];
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.tableFooterView = [[UIView alloc] init];
    tableView.rowHeight = 44;
    [self.view addSubview:tableView];
    
  
//  NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
//  NSString *filePath = [documentPath stringByAppendingPathComponent:@"file.archiver"];
//  BYStudent *student = [[BYStudent alloc] init];
//  student.name = @"by";
//  student.age = @"18";
//  [NSKeyedArchiver archiveRootObject:student toFile:filePath];
//  @try {
//    BYStudent *student = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
//  } @catch (NSException *exception) {
//     NSLog(@"错误");
//  }
  
  
  
//  NSArray *array = @[@"123" ,@"321"];
//  @try {
//    NSString *str = array[3];
//    NSLog(@"错误%@",str);
//  } @catch (NSException *exception) {
//
//    NSLog(@"数组越界,%@",exception.reason);
//  }
  
  
    
//    //信号量锁
//    dispatch_semaphore_t semaphore;
//    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_NOW);
//    
//    dispatch_semaphore_signal(semaphore);
    double delayInSeconds = 3.0;
    dispatch_queue_t mainQueue = dispatch_get_main_queue();
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds* NSEC_PER_SEC);
    dispatch_after(popTime, mainQueue, ^{
//        NSLog(@"延时执行的3秒");
    });
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.itemArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    VedHomeModel *model = self.itemArray[indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
        cell.detailTextLabel.numberOfLines = 0;
        cell.detailTextLabel.textColor = [UIColor grayColor];
    }
    cell.textLabel.text = model.title;
    cell.detailTextLabel.text = model.detail;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    VedHomeModel *model = self.itemArray[indexPath.row];
    UIViewController *vc = [[model.vcClass alloc] init];
    vc.navigationItem.title = model.title;
    [self.navigationController pushViewController:vc animated:YES];
}
@end
