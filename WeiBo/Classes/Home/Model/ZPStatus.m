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

- (void)setPic_urls:(NSArray *)pic_urls
{
    _pic_urls = pic_urls;
    [self countRowHigth];
}

- (void)setRetweeted_status:(ZPStatus *)retweeted_status
{
    _retweeted_status = retweeted_status;
    [self countRowHigth];
}

- (void)countRowHigth
{
    self.rowHight = 0;
    CGFloat margin = 10;
    CGFloat iconHight = 44;
    // 没有转发微博的情况
    self.picsHight = [self reSetPicViewSize];
    CGFloat toolViewHigth = 44;
    CGFloat width = [UIScreen mainScreen].bounds.size.width - 20;
    if (self.retweeted_status != nil) {
        CGFloat textHight = [self heightForString:self.retweeted_status.text fontSize:17 width:width];
        CGFloat textHightTwo = [self heightForString:self.text fontSize:17 width:width];
        self.rowHight =  8 * margin + iconHight + textHight + self.picsHight.height + toolViewHigth + textHightTwo - 1;
        return;
    }
    CGFloat textHight = [self heightForString:self.text fontSize:17 width:width];
    self.rowHight = 4 * margin + iconHight + textHight + self.picsHight.height + toolViewHigth - 2;
}

- (CGFloat)heightForString:(NSString *)value fontSize:(float)fontSize width:(CGFloat)width
{
    CGSize sizeToFit = [value boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:17]} context:nil].size;
    return sizeToFit.height;
}

- (CGSize)reSetPicViewSize
{
    // 1.处理没有配图的情况
    NSUInteger count = self.pic_urls.count;
    if (self.retweeted_status != nil) {
        count = self.retweeted_status.pic_urls.count;
    }
    if (count == 0) {
        return CGSizeZero;
    }
    
    // 2.计算行数列数
    NSUInteger maxCols = count == 4 ? 2 : 3;
    NSUInteger col = count > 3? maxCols : count;
    NSUInteger row = 1;
    if (count % 3 == 0) {
        row = count / 3;
    }else
    {
        row = count / 3 + 1;
    }
    
    // 3.计算宽高
    CGFloat pictureHeigth = 90;
    CGFloat pictureWidth = 90;
    CGFloat pictureMargin = 10; // 间隙
    
    // 宽度 = 列数 * 配图的宽度 + (列数 - 1) * 间隙
    CGFloat photosWidth = col * pictureWidth + (col - 1) * pictureMargin;
    // 高度= 行数 * 配图的高度 + (行数 - 1) * 间隙
    CGFloat photosHeight = row * pictureHeigth + (row - 1) * pictureMargin;
    
    return CGSizeMake(photosWidth, photosHeight);
}

- (NSString *)created_at
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.locale = [NSLocale localeWithLocaleIdentifier:@"en_US"];
    formatter.dateFormat = @"EEE MMM dd HH:mm:ss Z yyyy";
    NSDate *createdDate = [formatter dateFromString:_created_at];

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
