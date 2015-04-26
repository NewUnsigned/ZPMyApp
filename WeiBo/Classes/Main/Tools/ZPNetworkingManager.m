//
//  ZPNetworkingManager.m
//  WeiBo
//
//  Created by 赵鹏 on 15/4/25.
//  Copyright (c) 2015年 赵鹏. All rights reserved.
//

#import "ZPNetworkingManager.h"
#import <AFNetworking.h>
#import "ZPAccount.h"


@implementation ZPNetworkingManager

static ZPNetworkingManager *_instance;
+ (instancetype)downloadManager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSURL *baseURL = [NSURL URLWithString:@"https://api.weibo.com"];
        _instance = [[ZPNetworkingManager alloc]initWithBaseURL:baseURL sessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
        _instance.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/plain", nil];
    });
    return _instance;
}

- (void)getAccessTokenWithCode:(NSString *)code success:(successBlock)success failuer:(failuerBlock)failuer
{
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    parameter[@"client_id"] = ZP_CLIENT_ID;
    parameter[@"client_secret"] = ZP_SECRET;
    parameter[@"grant_type"] = @"authorization_code";
    parameter[@"code"] = code;
    parameter[@"redirect_uri"] = ZP_REDIRECT_URL;
    
    [self POST:ZP_ACCESSTOKEN_URL parameters:parameter success:^(NSURLSessionDataTask *task, id responseObject) {
        if (success != nil) {
            success(task,responseObject);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        failuer(task,error);
    }];
}

- (void)loadWeiBoInfomation:(successBlock)success failuer:(failuerBlock)failuer
{
    //取出请求需要的参数
    ZPAccount *acount = [ZPAccount accountFromSandbox];
    NSMutableDictionary *parater = [NSMutableDictionary dictionary];
    if (acount == nil) {
        return;
    }
    parater[@"access_token"] = acount.access_token;
    
    [self GET:@"https://api.weibo.com/2/statuses/home_timeline.json" parameters:parater success:^(NSURLSessionDataTask *task, id responseObject) {
        if (success != nil) {
            success(task,responseObject);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (failuer != nil) {
            failuer(task,error);
        }
    }];
}

- (void)loadNewStatusWithIdstr:(NSString *)idstr header:(BOOL)header success:(successBlock)success failure:(failuerBlock)failure
{
    ZPAccount *acount = [ZPAccount accountFromSandbox];
    NSMutableDictionary *parater = [NSMutableDictionary dictionary];
    parater[@"access_token"] = acount.access_token;
    if (header) {
        parater[@"since_id"] = idstr;
    }else
    {
        parater[@"max_id"] = idstr;
    }
    
    [self GET:@"/2/statuses/home_timeline.json" parameters:parater success:^(NSURLSessionDataTask *task, id responseObject) {
        if (success != nil) {
            success(task,responseObject);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (failure != nil) {
            failure(task,error);
        }
    }];
}

@end
