//
//  BYSingleLetonViewController.m
//  BYExample
//
//  Created by 付宝阳 on 2017/5/6.
//  Copyright © 2017年 付宝阳. All rights reserved.
//

#import "BYSingleLetonViewController.h"
#import "BYSingleLeton.h"

@interface BYSingleLetonViewController ()

@end

@implementation BYSingleLetonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    //单例模式
        BYSingleLeton* obj1 = [BYSingleLeton sharedSingleLeton] ;
        NSLog(@"obj1 = %@.", obj1) ;
    
        BYSingleLeton* obj2 = [BYSingleLeton sharedSingleLeton] ;
        NSLog(@"obj2 = %@.", obj2) ;
    
        BYSingleLeton* obj3 = [[BYSingleLeton alloc] init] ;
        NSLog(@"obj3 = %@.", obj3) ;
    
        BYSingleLeton* obj4 = [[BYSingleLeton alloc] init] ;
        NSLog(@"obj4 = %@.", [obj4 copy]) ;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)goback:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
