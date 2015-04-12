//
//  ZPProfileInfo.h
//  WeiBo
//
//  Created by 赵鹏 on 15/4/12.
//  Copyright (c) 2015年 赵鹏. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZPProfileInfo : NSObject
///  用户头像地址（中图），50×50像素
@property (nonatomic, copy) NSString *profile_image_url;
///  用户昵称
@property (nonatomic, copy) NSString *screen_name;
///  用户所在地
@property (nonatomic, copy) NSString *location;
///  性别
@property (nonatomic, copy) NSString *gender;
///  粉丝数
@property (nonatomic, copy) NSString *followers_count;
///  关注数
@property (nonatomic, copy) NSString *friends_count;
@end
