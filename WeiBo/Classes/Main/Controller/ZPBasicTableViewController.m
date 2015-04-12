//
//  ZPBasicTableViewController.m
//  WeiBo
//
//  Created by 赵鹏 on 15/4/11.
//  Copyright (c) 2015年 赵鹏. All rights reserved.
//

#import "ZPBasicTableViewController.h"
#import "ZPLogViewController.h"
#import "ZPAuthViewController.h"
#import "ZPAccount.h"

@interface ZPBasicTableViewController () <ZPLogViewControllerDelegate>

@end

@implementation ZPBasicTableViewController
ZPLogViewController *vc;
- (void)viewDidLoad {
    [super viewDidLoad];
    ZPAccount *count = [ZPAccount accountFromSandbox];
    if (count == nil) {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Basic" bundle:nil];
    vc = sb.instantiateInitialViewController;
    CGRect tempX = vc.view.frame;
    tempX.origin.y = 64;
    vc.view.frame = tempX;
    vc.delegate = self;
    vc.imgDown.image = self.upImg;
    vc.degestLabel.text = self.degestLbl;
    [self.navigationController.view addSubview:vc.view];
    }
}

#pragma mark - ZPLogViewControllerDelegate
- (void)logVC:(ZPLogViewController *)loginVC loginButton:(UIButton *)button
{

    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"LogRegister" bundle:nil];
    ZPAuthViewController *authVC = sb.instantiateInitialViewController;
    [self presentViewController:authVC animated:YES completion:nil];

}
- (void)registerVC:(ZPLogViewController *)registerVC registerButton:(UIButton *)button
{
    NSLog(@"%s",__func__);
}
- (void)setDegestLbl:(NSString *)degestLbl
{
    _degestLbl = degestLbl;
    vc.degestLabel.text = degestLbl;
}

- (void)setImagDown:(UIImage *)imagDown
{
    _imagDown = imagDown;
    vc.imgDown.image = imagDown;
}
- (void)setUpImg:(UIImage *)upImg
{
    _upImg = upImg;
    vc.upImg.image = upImg;
}
-(void)setMidImg:(UIImage *)midImg
{
    _midImg = midImg;
    vc.midImage.image = midImg;
}

@end
