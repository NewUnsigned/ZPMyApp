//
//  ZPNetworkingManager.h
//  WeiBo
//
//  Created by 赵鹏 on 15/4/25.
//  Copyright (c) 2015年 赵鹏. All rights reserved.
//

#define ZP_SECRET @"b3c26d76af109c1657c6c7912b5acbab"
#define ZP_REDIRECT_URL @"http://www.baidu.com"
#define ZP_ACCESSTOKEN_URL @"https://api.weibo.com/oauth2/access_token"
#define ZP_CLIENT_ID @"422720824"

#import <AFNetworking/AFNetworking.h>
typedef void(^successBlock)(NSURLSessionDataTask *task, id responseObject);
typedef void(^failuerBlock)(NSURLSessionDataTask *task, NSError *error);

@interface ZPNetworkingManager : AFHTTPSessionManager

+ (instancetype)downloadManager;
//定义一个更新微博的函数
- (void)loadNewStatusWithIdstr:(NSString *)idstr header:(BOOL)header success:(successBlock)success failure:(failuerBlock)failure;

//下载微博数据
- (void)loadWeiBoInfomation:(successBlock)success failuer:(failuerBlock)failuer;

//获取AccessToken
- (void)getAccessTokenWithCode:(NSString *)code success:(successBlock)success failuer:(failuerBlock)failuer;
@end



