//
//  ZPStatus.m
//  WeiBo
//
//  Created by 赵鹏 on 15/4/12.
//  Copyright (c) 2015年 赵鹏. All rights reserved.
//

#import "ZPStatus.h"
#import "ZPPhoto.h"
#import "NSDate+NJ.h"

@implementation ZPStatus
+ (NSDictionary *)objectClassInArray
{
    return @{@"pic_urls": [ZPPhoto class]};
}
- (void)setSource:(NSString *)source{
    _source = [source copy];
    
    if ([_source isEqualToString:@""] || _source == nil) {
        return;
    }
    // 1.计算截取字符串开始的位置
    NSRange startRange = [_source rangeOfString:@">"];
    NSInteger startIndex = startRange.location + 1;
    
    // 2.计算长度
    // rangeOfString是从字符串的第一个开始查找 只要找到就不会继续往后找
    NSRange endRange = [_source rangeOfString:@"</"];
    NSInteger length = endRange.location - startIndex;
    
    // 3.截取字符串是通过, 字符串开始的位置和字符串的长度来截取
    NSRange range = NSMakeRange(startIndex, length);
    NSString *str = [_source substringWithRange:range];
    
    _source =  [NSString stringWithFormat:@"来自:%@", str];
}
- (NSString *)created_at
{
    // 新浪返回给我们的时间, 是微博发布的时间
    // 而我们需要显示的时间, 是距离发布时间的差值
    //  Sun Apr 12 10:15:04 +0800 2015
    //    _created_at = @"Sun Apr 12 10:15:04 +0800 2014";
    // 1.将服务器返回的时间, 转换为NSDate
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    // 注意: 如果是真机, 最好写上下面这段话, 告诉系统我们的格式属于哪个时区
    formatter.locale = [NSLocale localeWithLocaleIdentifier:@"en_US"];
    formatter.dateFormat = @"EEE MMM dd HH:mm:ss Z yyyy";
    NSDate *createdDate = [formatter dateFromString:_created_at];
    /*
     // 2.获取本地的时间
     NSDate *now = [NSDate date];
     // 日历类, 它可以用于比较时间, 因为它可以获取某一个时间的年月日时分秒
     NSCalendar *cal = [NSCalendar currentCalendar];
     // 从指定的时间中获取时间的组成成分(年月日时分秒)
     // NSDateComponents中就存储这所有取出来的成分
     NSCalendarUnit flags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
     // 取出当前时间的年月日
     NSDateComponents *cmps1 = [cal components:flags fromDate:now];
     // 取出服务器时间的年月日
     NSDateComponents *cmps2 = [cal components:flags fromDate:createdDate];
     // 3.利用本地时间和服务器的时间进行比较
     if (cmps1.year == cmps2.year) {
     DDLogInfo(@"同一年");
     }else if(cmps1.year == cmps2.year && cmps1.month == cmps2.month){
     DDLogInfo(@"同年同月");
     }else if(cmps1.year == cmps2.year &&
     cmps1.month == cmps2.month &&
     cmps1.day == cmps2.day){
     DDLogInfo(@"今天");
     }
     */
    
    /*
     新浪的时间分为3大类:
     1. 今年和非今年
     2. 今天/昨天/其它天
     3. 1分钟以内/1小时以内/其它小时
     
     1.今年发布
     >今天
     *1分钟内:刚刚
     *1个小时内:XX分钟前
     *其它:XX小时前
     
     服务器 2015-4-12 11:02:00
     当前:  2015-4-12 12:03:00
     
     >昨天
     *昨天 XX时:XX分
     
     >其它
     　＊xx月xx日  XX时:XX分
     
     2.非今年发布
     　＊xx年xx月xx日  XX时:XX分
     */
    
    if ([createdDate isThisYear]) {
        // 今年
        if ([createdDate isToday]) {
            // 今天
            NSDateComponents *cmps =[createdDate deltaWithNow];
            if (cmps.hour >= 1) {
                // 其它小时
                return [NSString stringWithFormat:@"%tu小时前", cmps.hour];
            }else if (cmps.minute > 1){
                // 1小时以内
                return [NSString stringWithFormat:@"%tu分钟前", cmps.minute];
            }else
            {
                // 1分钟以内
                return @"刚刚";
            }
            
        }else if ([createdDate isYesterday]){
            // 昨天
            formatter.dateFormat = @"昨天 HH时:mm分";
            return [formatter stringFromDate:createdDate];
        }else{
            // 其它天
            formatter.dateFormat = @"MM月dd日 HH时:mm分";
            return [formatter stringFromDate:createdDate];
        }
    }else
    {
        // 非今年
        formatter.dateFormat = @"yy年MM月dd日 HH时:mm分";
        return [formatter stringFromDate:createdDate];
    }
    
}
@end
