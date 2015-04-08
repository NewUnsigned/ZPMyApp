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
    [self addChildvcWithSbName:@"Message" title:@"消息" normalImage:@"tabbar_message_center" selectedImage:@"tabbar_message_center_highlighted"];
    [self addChildvcWithSbName:@"Discover" title:@"发现" normalImage:@"tabbar_discover" selectedImage:@"tabbar_discover_highlighted"];

    [self addChildvcWithSbName:@"Profile" title:@"我" normalImage:@"tabbar_profile" selectedImage:@"tabbar_profile_highlighted"];
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


@end
