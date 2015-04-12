//
//  ZPStatus.m
//  WeiBo
//
//  Created by 赵鹏 on 15/4/12.
//  Copyright (c) 2015年 赵鹏. All rights reserved.
//

#import "ZPStatus.h"
#import "ZPPhoto.h"

@implementation ZPStatus
+ (NSDictionary *)objectClassInArray
{
    return @{@"pic_urls": [ZPPhoto class]};
}
@end
