//
//  ZPSmallView.m
//  WeiBo
//
//  Created by 赵鹏 on 15/4/10.
//  Copyright (c) 2015年 赵鹏. All rights reserved.
//

#import "ZPSmallView.h"
#import "UIView+Extension.h"
#import "ZPSmallViewController.h"

@interface ZPSmallView ()
@property (nonatomic, strong) UIWindow *window;
@end

@implementation ZPSmallView

BOOL isHaveValue;
UIButton *_btn;
- (void)test:(UIView *)view button:(UIButton *)btn{
    _btn = btn;
    _window = [[UIWindow alloc]init];
    _window.frame = view.frame;//view的frame是变化的
    _window.hidden = NO;
    _window.windowLevel = UIWindowLevelAlert + 1;

    UIButton *smallBtn = [[UIButton alloc]init];
    [smallBtn addTarget:self action:@selector(smallBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    smallBtn.frame = view.frame;
    smallBtn.alpha = 0.2;
    smallBtn.backgroundColor = [UIColor grayColor];
    [_window addSubview:smallBtn];

    UIImageView *imgView = [[UIImageView alloc]init];
    CGFloat imgViewW = view.width * 0.5;
    CGFloat imgViewH = view.height * 0.4;
    CGFloat imgViewX = btn.x + btn.width * 0.5 - imgViewW * 0.5;
    CGFloat imgViewY = btn.y + btn.height + 20;
    imgView.frame = CGRectMake(imgViewX, imgViewY, imgViewW, imgViewH);
    imgView.image = [UIImage imageNamed:@"popover_background"];
    imgView.userInteractionEnabled = YES;
    [_window addSubview:imgView];

    ZPSmallViewController *smallVC = [[ZPSmallViewController alloc]init];
    smallVC.view.frame = CGRectMake(10, 15, (imgViewW - 20), (imgViewH - 25));
    [imgView addSubview:smallVC.view];
    if ([self.delegate respondsToSelector:@selector(buttonClicked)]) {
        [self.delegate buttonClicked];
    }
}

- (void)smallBtnClicked:(UIButton *)btn
{
    _btn.selected = !_btn.selected;
    _window = nil;
}
@end
