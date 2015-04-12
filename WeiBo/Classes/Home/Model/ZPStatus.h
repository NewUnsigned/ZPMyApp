//
//  ZPStatus.h
//  WeiBo
//
//  Created by 赵鹏 on 15/4/12.
//  Copyright (c) 2015年 赵鹏. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ZPUser;

@interface ZPStatus : NSObject
/** 字符串型的微博ID */
@property (nonatomic, copy) NSString *idstr;
/** 微博信息内容 */
@property (nonatomic, copy) NSString *text;
/** 微博创建时间 */
@property (nonatomic, copy) NSString *created_at;
/** 微博来源 */
@property (nonatomic, copy) NSString *source;

/** 转发数 */
@property (nonatomic, assign) int reposts_count;
/** 评论数 */
@property (nonatomic, assign) int comments_count;
/** 表态数(赞) */
@property (nonatomic, assign) int attitudes_count;

/** 微博作者的用户信息字段 */
@property (nonatomic, strong) ZPUser *user;

/** 被转发的原微博信息字段，当该微博为转发微博时返回 */
@property (nonatomic, strong) ZPStatus *retweeted_status;

/** 微博配图地址。多图时返回多图链接。无配图返回“[]” */
@property (nonatomic, strong) NSArray *pic_urls;
@end
