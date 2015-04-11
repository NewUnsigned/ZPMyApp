//
//  ZPLogViewController.m
//  WeiBo
//
//  Created by 赵鹏 on 15/4/11.
//  Copyright (c) 2015年 赵鹏. All rights reserved.
//

#import "ZPLogViewController.h"

@interface ZPLogViewController ()

@property (nonatomic, strong) CADisplayLink *timeLink;

@end

@implementation ZPLogViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.timeLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
}

- (IBAction)registerBtn:(id)sender {
    if ([self.delegate respondsToSelector:@selector(registerVC:registerButton:)]) {
        [self.delegate registerVC:self registerButton:sender];
    }
}

- (IBAction)logBtn:(id)sender {
    if ([self.delegate respondsToSelector:@selector(logVC:loginButton:)]) {
        [self.delegate logVC:self loginButton:sender];
    }
}

- (void)transformDownImage
{
    self.imgDown.transform = CGAffineTransformRotate(self.imgDown.transform, M_PI/500);
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.timeLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.timeLink removeFromRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
}

- (CADisplayLink *)timeLink
{
    if (_timeLink == nil) {
        _timeLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(transformDownImage)];
    }
    return _timeLink;
}

@end
