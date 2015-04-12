//
//  ZPProfileInfo.m
//  WeiBo
//
//  Created by 赵鹏 on 15/4/12.
//  Copyright (c) 2015年 赵鹏. All rights reserved.
//

#import "ZPProfileInfo.h"
#import "NSString+Extension.h"

@implementation ZPProfileInfo

// 归档的时候调用
- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:self.profile_image_url forKey:@"profile_image_url"];
    [encoder encodeObject:self.screen_name forKey:@"screen_name"];
    [encoder encodeObject:self.location forKey:@"location"];
    [encoder encodeObject:self.gender forKey:@"gender"];
    [encoder encodeObject:self.followers_count forKey:@"followers_count"];
    [encoder encodeObject:self.friends_count forKey:@"friends_count"];

}
// 解档的时候调用
- (id)initWithCoder:(NSCoder *)decoder
{
    if (self = [super init]) {
        self.profile_image_url = [decoder decodeObjectForKey:@"profile_image_url"];
        self.screen_name = [decoder decodeObjectForKey:@"screen_name"];
        self.location = [decoder decodeObjectForKey:@"location"];
        self.gender = [decoder decodeObjectForKey:@"gender"];
        self.followers_count = [decoder decodeObjectForKey:@"followers_count"];
        self.friends_count = [decoder decodeObjectForKey:@"friends_count"];

    }
    return self;
}

// 存储当前授权模型
- (BOOL)save{
    // 1.获取存储路径
    NSString *filePath = [@"profile.data" appendDocumentDir];
    // 2存储数据
    return  [NSKeyedArchiver archiveRootObject:self toFile:filePath];
}
// 读取当前授权模型
+ (instancetype)pfofileFromSandbox{
    // 1.获取存储路径
    NSString *filePath = [@"profile.data" appendDocumentDir];
    // 2.解归档授权信息
    ZPProfileInfo *profile = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
   
    return profile;
}
@end
