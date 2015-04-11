//
//  ZPLogViewController.h
//  WeiBo
//
//  Created by 赵鹏 on 15/4/11.
//  Copyright (c) 2015年 赵鹏. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZPLogViewController;

@protocol ZPLogViewControllerDelegate <NSObject>

- (void)logVC:(ZPLogViewController *)loginVC loginButton:(UIButton *)button;
- (void)registerVC:(ZPLogViewController *)registerVC registerButton:(UIButton *)button;

@end
@interface ZPLogViewController : UIViewController
@property (nonatomic, weak) id<ZPLogViewControllerDelegate> delegate;
@property (weak, nonatomic) IBOutlet UIImageView *upImg;
@property (weak, nonatomic) IBOutlet UIImageView *midImage;
@property (weak, nonatomic) IBOutlet UIImageView *imgDown;
@property (weak, nonatomic) IBOutlet UILabel *degestLabel;

@end
