//
//  ZPMainViewController.m
//  WeiBo
//
//  Created by 赵鹏 on 15/4/8.
//  Copyright (c) 2015年 赵鹏. All rights reserved.
//

#import "ZPMainViewController.h"

@interface ZPMainViewController ()

@end

@implementation ZPMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addChildVc];
}
- (void)addChildVc
{
    [self addChildvcWithSbName:@"Home" title:@"首页" normalImage:@"tabbar_home" selectedImage:@"tabbar_home_highlighted"];
    [self addChildvcWithSbName:@"Discover" title:@"发现" normalImage:@"tabbar_discover" selectedImage:@"tabbar_discover_highlighted"];
    [self addChildvcWithSbName:@"Home" title:@"首页" normalImage:@"tabbar_home" selectedImage:@"tabbar_home_highlighted"];
    [self addChildvcWithSbName:@"Home" title:@"首页" normalImage:@"tabbar_home" selectedImage:@"tabbar_home_highlighted"];
}

- (void)addChildvcWithSbName:(NSString *)sbName title:(NSString *)title normalImage:(NSString *)normal selectedImage:(NSString *)selected
{
    UIStoryboard *sb = [UIStoryboard storyboardWithName:sbName bundle:nil];
    UINavigationController *vc = sb.instantiateInitialViewController;
    vc.tabBarController.tabBar.tintColor = [UIColor orangeColor];
    vc.title = title;
    [vc.tabBarItem setImage:[UIImage imageNamed:normal]];
    [vc.tabBarItem setSelectedImage:[UIImage imageNamed:selected]];
    
    [self addChildViewController:vc];
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
