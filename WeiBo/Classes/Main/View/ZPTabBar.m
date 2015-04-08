//
//  ZPTabBar.m
//  WeiBo
//
//  Created by 赵鹏 on 15/4/8.
//  Copyright (c) 2015年 赵鹏. All rights reserved.
//

#import "ZPTabBar.h"

@interface ZPTabBar ()
@property (nonatomic, strong) UIButton *plusBtn;
@end

@implementation ZPTabBar

- (void)layoutSubviews{
    [super layoutSubviews];
    
    NSInteger index      = 0;
    CGFloat   barButtonX = 0;
    CGFloat   barButtonY = 0;
    CGFloat   barButtonW = self.frame.size.width / 5;
    CGFloat   barButtonH = self.frame.size.height;
    
    for (UIView *subview in self.subviews) {
        if ([subview isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            if (index == 2) {
                barButtonX = index * barButtonW;
                self.plusBtn.frame = CGRectMake(barButtonX,barButtonY,barButtonW,barButtonH);
                index++;
            }
            barButtonX    = index * barButtonW;
            subview.frame = CGRectMake(barButtonX,barButtonY,barButtonW,barButtonH);
            index++;
        }
    }
}

#pragma lazy
- (UIButton *)plusBtn
{
    if (!_plusBtn) {
        // 1.创建加号按钮
        _plusBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_plusBtn addTarget:self action:@selector(compose) forControlEvents:UIControlEventTouchUpInside];
        // 2.设置按钮的image图片
        [_plusBtn setImage:[UIImage imageNamed:@"tabbar_compose_icon_add"] forState:UIControlStateNormal];
        [_plusBtn setImage:[UIImage imageNamed:@"tabbar_compose_icon_add_highlighted"] forState:UIControlStateHighlighted];
        // 3.设置按钮的背景Image图片
        [_plusBtn setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button"] forState:UIControlStateNormal];
        [_plusBtn setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button_highlighted"] forState:UIControlStateHighlighted];
        // 添加到父控件
        [self addSubview:_plusBtn];
    }
    return _plusBtn;
}

- (void)compose
{
    NSLog(@"%s",__func__);
}
/*
{
    CGFloat barButtonW ;
    CGFloat barButtonY ;
    CGFloat barButtonH ;
    CGFloat barButtonX ;
    NSInteger index ;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    index = 0;
    barButtonW = self.frame.size.width / 5;
    barButtonH = self.frame.size.height;
    for (UIView *subview in self.subviews) {
        if ([subview isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            if (index == 2) {
                [self setBarButtonFrame:self.plusBtn];
            }
            [self setBarButtonFrame:subview];
        }
    }
}
- (void)setBarButtonFrame:(UIView *)view
{
    barButtonX = index * barButtonW;
    view.frame = CGRectMake(barButtonX,barButtonY,barButtonW,barButtonH);
    index++;
}
*/
@end
