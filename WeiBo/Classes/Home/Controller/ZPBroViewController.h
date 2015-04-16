//
//  ZPBroViewController.h
//  WeiBo
//
//  Created by 赵鹏 on 15/4/16.
//  Copyright (c) 2015年 赵鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZPBroViewController : UIViewController

//需要显示的图片字符串url地址,因为会有很多图片,所以传进来的应该是个数组
@property (nonatomic, strong) NSArray *urlStrArr;
//需要显示多少张图片
@property (nonatomic, strong) NSIndexPath *indexPath;
@end
