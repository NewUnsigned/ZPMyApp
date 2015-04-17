//
//  ZPPhoto.m
//  WeiBo
//
//  Created by 赵鹏 on 15/4/12.
//  Copyright (c) 2015年 赵鹏. All rights reserved.
//

#import "ZPPhoto.h"

@implementation ZPPhoto
- (NSString *)bmiddle_pic
{
    // http://ww3.sinaimg.cn/thumbnail/67917f57gw1ep005k4xx6j20c81ia7c7.jpg
    return [_thumbnail_pic stringByReplacingOccurrencesOfString:@"thumbnail" withString:@"bmiddle"];
}

- (NSString *)original_pic
{
    return [_thumbnail_pic stringByReplacingOccurrencesOfString:@"thumbnail" withString:@"large"];
}
@end
