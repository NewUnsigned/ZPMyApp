//
//  ZPProfileViewController.m
//  WeiBo
//
//  Created by 赵鹏 on 15/4/8.
//  Copyright (c) 2015年 赵鹏. All rights reserved.
//

#import "ZPProfileViewController.h"

@interface ZPProfileViewController ()

@end

@implementation ZPProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.degestLbl = @"登录后你的微博,相册,个人质料会显示在这里,展示给别人";
    self.upImg = [UIImage imageNamed:@"visitordiscover_image_profile"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
