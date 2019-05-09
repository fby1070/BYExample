//
//  BYMessageCell.m
//  BYExample
//
//  Created by 付宝阳 on 2017/5/22.
//  Copyright © 2017年 付宝阳. All rights reserved.
//

#import "BYMessageCell.h"

@implementation BYMessageCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
  return nil;
}

@end
