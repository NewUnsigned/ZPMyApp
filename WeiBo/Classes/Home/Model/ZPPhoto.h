//
//  ZPPhoto.h
//  WeiBo
//
//  Created by 赵鹏 on 15/4/12.
//  Copyright (c) 2015年 赵鹏. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZPPhoto : NSObject
/** 缩略图 */
@property (nonatomic, copy) NSString *thumbnail_pic;
// 中等图
@property (nonatomic, copy) NSString *bmiddle_pic;
// 原始图
@property (nonatomic, copy) NSString *original_pic;
@end
