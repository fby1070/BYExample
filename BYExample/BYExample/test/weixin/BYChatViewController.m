//
//  BYChatViewController.m
//  BYExample
//
//  Created by 付宝阳 on 2017/5/18.
//  Copyright © 2017年 付宝阳. All rights reserved.
//

#import "BYChatViewController.h"
#import "BYMessage.h"

@interface BYChatViewController ()

@end

@implementation BYChatViewController {
    NSArray *_messageArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
   // self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:55.0/255.0 green:53.0/255.0 blue:58.0/255.0 alpha:1.0];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"WX20170518-130413"] forBarMetrics:0];
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    self.title = @"宝宝";

    UIButton *leftButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 70, 40)];
    [leftButton addTarget:self action:@selector(goback) forControlEvents:UIControlEventTouchUpInside];
    [leftButton setTitle:@"微信" forState:UIControlStateNormal];
    [leftButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [leftButton setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    leftButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    UIBarButtonItem *leftButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    
    UIButton *rightButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 70, 40)];
    [rightButton setImage:[UIImage imageNamed:@"people"] forState:UIControlStateNormal];
    rightButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    UIBarButtonItem *rightButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    
    self.navigationItem.leftBarButtonItem = leftButtonItem;
    self.navigationItem.rightBarButtonItem = rightButtonItem;
    
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    _messageArray = [self dataSource];
}

- (NSArray *)dataSource {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"message" ofType:@"plist"];
    NSArray *dicArray = [NSArray arrayWithContentsOfFile:path];
    NSMutableArray *array = [[NSMutableArray alloc] init];
    for (NSDictionary *dic in dicArray) {
        [array addObject:[BYMessage messageWithDict:dic]];
    }
    return array;
}

- (void)goback {
//    [self dismissViewControllerAnimated:YES completion:nil];
    [self.navigationController popViewControllerAnimated:YES];
}
@end
