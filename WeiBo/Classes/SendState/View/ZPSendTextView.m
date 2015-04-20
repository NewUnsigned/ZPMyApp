//
//  ZPSendTextView.m
//  WeiBo
//
//  Created by 赵鹏 on 15/4/17.
//  Copyright (c) 2015年 赵鹏. All rights reserved.
//

#import "ZPSendTextView.h"
#import "UIView+Extension.h"

@interface ZPSendTextView ()
@end

@implementation ZPSendTextView

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        [self setTExtLabel];
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setTExtLabel];
    }
    return self;
}

- (void)setTExtLabel
{
    UILabel *lb = [[UILabel alloc]init];
    lb.text = @"分享新鲜事...";
    lb.x = 5;
    lb.y = 7;
    lb.textColor = [UIColor lightGrayColor];
    lb.font = [UIFont systemFontOfSize:14];
    [lb sizeToFit];
    self.textLbl = lb;
    [self addSubview:lb];
}

@end
