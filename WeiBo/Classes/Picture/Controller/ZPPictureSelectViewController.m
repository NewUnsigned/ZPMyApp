//
//  ZPPictureSelectViewController.m
//  WeiBo
//
//  Created by 赵鹏 on 15/4/19.
//  Copyright (c) 2015年 赵鹏. All rights reserved.
//

#import "ZPPictureSelectViewController.h"
#import "ZPButton.h"
#import "UIView+Extension.h"

@interface ZPPictureSelectViewController ()
@property (nonatomic, strong) UIButton *btn;
@property (nonatomic, strong) UIView *colView;
@property (nonatomic, assign) CGFloat colViewH;

@property (nonatomic, assign) BOOL isColViewHidden;
@end

@interface ZPPictureSelectViewController ()

- (IBAction)dismissBtn:(id)sender;


@end

@implementation ZPPictureSelectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //设置标题按钮
    [self setTitleView];
}
- (void)setTitleView
{
    _btn = [[ZPButton alloc]init];
    _btn.adjustsImageWhenHighlighted = NO;
    self.navigationItem.titleView = _btn;
    [_btn setTitle:@"全部图片" forState:UIControlStateNormal];
    [_btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_btn setImage:[UIImage imageNamed:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
    [_btn setImage:[UIImage imageNamed:@"navigationbar_arrow_up"] forState:UIControlStateSelected];
    
    [_btn sizeToFit];
    [_btn addTarget:self action:@selector(titleViewBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    
    _colView = [[UIView alloc]init];
    CGFloat colViewX = 0;
    CGFloat colViewW = [UIScreen mainScreen].bounds.size.width;
           _colViewH = colViewW;
    CGFloat colViewY = - _colViewH + 64;
    _colView.frame = CGRectMake(colViewX, colViewY, colViewW, _colViewH);
    _colView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:_colView];
    
    _isColViewHidden = YES;
}
- (void)titleViewBtnClicked
{

    if (_isColViewHidden) {
        [UIView animateWithDuration:0.25 animations:^{
            _colView.y = 64;
            self.btn.selected = YES;
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.125 animations:^{
                    _colView.y += 10;
            } completion:^(BOOL finished) {
                [UIView animateWithDuration:0.125 animations:^{
                    _colView.y -= 10;
                    _isColViewHidden = NO;
                }];
            }];
        }];
    }else{
        [UIView animateWithDuration:0.125 animations:^{
                    _colView.y += 10;
                    } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.125 animations:^{
                _colView.y -= 10;
            } completion:^(BOOL finished) {
                [UIView animateWithDuration:0.25 animations:^{
                    _colView.y = - _colViewH + 64;
                    self.btn.selected = YES;
                    _isColViewHidden = YES;
                }];
            }];
        }];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)dismissBtn:(id)sender {

    [self dismissViewControllerAnimated:YES completion:^{

    }];
 }
@end
