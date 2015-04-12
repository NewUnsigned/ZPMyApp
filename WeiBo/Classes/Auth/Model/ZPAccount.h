//
//  ZPAccount.h
//  WeiBo
//
//  Created by 赵鹏 on 15/4/12.
//  Copyright (c) 2015年 赵鹏. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZPAccount : NSObject <NSCoding>

// 令牌
@property (nonatomic, copy) NSString *access_token;
// 过期时间, 告诉用户多少秒之后过期
@property (nonatomic, copy) NSString *expires_in;
// 真正的过期时间, 从授权成功的那一刻开始加上expires_in(多少秒之后过期)
@property (nonatomic, strong) NSDate *expires_time;
// 过期提醒时间
@property (nonatomic, copy) NSString *remind_in;
// 用户ID
@property (nonatomic, copy) NSString *uid;

+ (instancetype)accountWithDict:(NSDictionary *)dict;
/*
 "access_token" = "2.00VpcZnB0ozgb927dc355d55L79IaE";
 "expires_in" = 157679999;
 "remind_in" = 157679999;
 uid = 1648664041;
 */
// 存储当前授权模型
- (BOOL)save;
// 读取当前授权模型
+ (instancetype)accountFromSandbox;
@end
