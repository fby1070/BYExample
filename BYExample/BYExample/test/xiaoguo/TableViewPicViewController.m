//
//  TableViewPicViewController.m
//  BYExample
//
//  Created by 付宝阳 on 2017/8/14.
//  Copyright © 2017年 付宝阳. All rights reserved.
//

#import "TableViewPicViewController.h"
#import "ToolLoading.h"


@interface TableViewPicViewController ()
@property (nonatomic, strong) ToolLoading *tool;
@end

@implementation TableViewPicViewController {
  UIImageView *_headerImageView;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  self.tableView.delegate = self;
  self.tableView.dataSource = self;
  self.title = @"正常";
  self.tool = [[ToolLoading alloc] initWith:self tableView:self.tableView];
  [self.tool start];
  self.automaticallyAdjustsScrollViewInsets = NO;
  _headerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, -200, self.view.frame.size.width, 250)];
  _headerImageView.contentMode = UIViewContentModeScaleAspectFill;
  _headerImageView.image = [UIImage imageNamed:@"ting"];

  
  self.tableView.contentInset = UIEdgeInsetsMake(250, 0, 0, 0);
  [self.tableView addSubview:_headerImageView];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"tableView"];
  cell.textLabel.text = [NSString stringWithFormat:@"第%ld行", indexPath.row];
  return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  [self.tool cancel];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
  CGPoint point = scrollView.contentOffset;
//  NSLog(@"%f --- %f",point.y, point.x);
  if (point.y < -250) {
    CGRect rect = _headerImageView.frame;
//  NSLog(@"%f --- %f",rect.origin.y, rect.origin.x);
    rect.origin.y = point.y;
    rect.size.height = -point.y;
    _headerImageView.frame = rect;
  }
}


- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}



@end
