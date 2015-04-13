//
//  ZPBarcodeViewController.m
//  WeiBo
//
//  Created by 赵鹏 on 15/4/9.
//  Copyright (c) 2015年 赵鹏. All rights reserved.
//

#import "ZPBarcodeViewController.h"

@interface ZPBarcodeViewController ()
//冲击波的向下的约束
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *hightConstraint;
//定时器
@property (nonatomic, strong) CADisplayLink *timeLink;

@end

@implementation ZPBarcodeViewController
- (IBAction)closeScanView:(id)sender {
    [self.timeLink removeFromRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
    self.hightConstraint.constant = 200;
    [self dismissViewControllerAnimated:YES completion:^{
    }];
}
- (IBAction)photoAlbum:(id)sender {
}

#pragma mark - UIViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.timeLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
}

//- (void)viewWillDisappear:(BOOL)animated {
//    [super viewWillDisappear:animated];
//    [self.timeLink removeFromRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
//}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)runWave
{
    self.hightConstraint.constant -= 2;
    if (self.hightConstraint.constant <= -200) {
        self.hightConstraint.constant = 200;
    }
}

- (CADisplayLink *)timeLink
{
    if (_timeLink == nil) {
        _timeLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(runWave)];
    }
    return _timeLink;
}

@end
