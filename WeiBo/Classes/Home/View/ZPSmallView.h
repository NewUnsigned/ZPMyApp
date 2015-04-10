//
//  ZPSmallView.h
//  WeiBo
//
//  Created by 赵鹏 on 15/4/10.
//  Copyright (c) 2015年 赵鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ZPSmallViewDelegate <NSObject>

- (void)buttonClicked;

@end

@interface ZPSmallView : UIView

@property (nonatomic, weak) id<ZPSmallViewDelegate> delegate;

- (void)test:(UIView *)view button:(UIButton *)btn;

@end
