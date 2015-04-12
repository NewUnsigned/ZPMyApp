//
//  ZPAccount.m
//  WeiBo
//
//  Created by 赵鹏 on 15/4/12.
//  Copyright (c) 2015年 赵鹏. All rights reserved.
//

#import "ZPAccount.h"
#import "NSString+Extension.h"

@implementation ZPAccount
+ (instancetype)accountWithDict:(NSDictionary *)dict
{
    ZPAccount *account = [[self alloc] init];
    account.access_token = dict[@"access_token"];
    account.expires_in = dict[@"expires_in"];
    account.remind_in = dict[@"remind_in"];
    account.uid = dict[@"uid"];
    
    // 1.获取当前时间
    NSDate *now = [NSDate date];
    // 2.在当前时间的基础上加上多少秒之后过期
    account.expires_time = [now dateByAddingTimeInterval:[account.expires_in doubleValue]];
    
    return account;
}
// 归档的时候调用
- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:self.access_token forKey:@"access_token"];
    [encoder encodeObject:self.expires_in forKey:@"expires_in"];
    [encoder encodeObject:self.remind_in forKey:@"remind_in"];
    [encoder encodeObject:self.uid forKey:@"uid"];
    [encoder encodeObject:self.expires_time forKey:@"expires_time"];
}
// 解档的时候调用
- (id)initWithCoder:(NSCoder *)decoder
{
    if (self = [super init]) {
        self.access_token = [decoder decodeObjectForKey:@"access_token"];
        self.expires_in = [decoder decodeObjectForKey:@"expires_in"];
        self.remind_in = [decoder decodeObjectForKey:@"remind_in"];
        self.uid = [decoder decodeObjectForKey:@"uid"];
        self.expires_time = [decoder decodeObjectForKey:@"expires_time"];
    }
    return self;
}

// 存储当前授权模型
- (BOOL)save{
    // 1.获取存储路径
    NSString *filePath = [@"account.data" appendDocumentDir];
    // 2存储数据
    return  [NSKeyedArchiver archiveRootObject:self toFile:filePath];
}
// 读取当前授权模型
+ (instancetype)accountFromSandbox{
    // 1.获取存储路径
    NSString *filePath = [@"account.data" appendDocumentDir];
    // 2.解归档授权信息
    //    return [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
    ZPAccount *account = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
    // 3.判断授权是否过期
    // 3.1获取当前的时间
    // 当前:2021-04-09 07:02:45 +0000
    // 过期:2020-04-09 07:02:45 +0000
    NSDate *now = [NSDate date];
    //    NSDate *now = [account.expires_time dateByAddingTimeInterval:5];
    // 123456
    if ([now compare:account.expires_time] != NSOrderedAscending) {
        return nil;
    }
    return account;
}
@end
