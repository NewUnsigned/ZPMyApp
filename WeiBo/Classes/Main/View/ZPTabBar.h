//
//  ZPTabBar.h
//  WeiBo
//
//  Created by 赵鹏 on 15/4/8.
//  Copyright (c) 2015年 赵鹏. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZPTabBar;
@protocol ZPTabBarCustomDelegate<NSObject>

- (void)tabbar:(ZPTabBar *)tabbar plusButtonClicked:(UIButton *)plusBtn;

@end

@interface ZPTabBar : UITabBar

@property (nonatomic, weak) id<ZPTabBarCustomDelegate> customDelegate;

@end
