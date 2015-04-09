//
//  ZPScanViewController.m
//  WeiBo
//
//  Created by 赵鹏 on 15/4/9.
//  Copyright (c) 2015年 赵鹏. All rights reserved.
//

#import "ZPScanViewController.h"

@interface ZPScanViewController ()
- (IBAction)closeScanView:(id)sender;

- (IBAction)photoAlbum:(id)sender;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *hightConstraint;
//定时器
@property (nonatomic, strong) CADisplayLink *timeLink;

@end
@implementation ZPScanViewController

- (IBAction)closeScanView:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
    }];
}

#pragma mark - UIViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.timeLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.timeLink removeFromRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
}

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

- (IBAction)photoAlbum:(id)sender {
}
@end
