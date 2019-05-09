//
//  TableViewPicViewController.h
//  BYExample
//
//  Created by 付宝阳 on 2017/8/14.
//  Copyright © 2017年 付宝阳. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableViewPicViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, weak) IBOutlet UITableView *tableView;

@end
