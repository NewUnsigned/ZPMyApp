//
//  ZPBroCollectionViewCell.m
//  WeiBo
//
//  Created by 赵鹏 on 15/4/16.
//  Copyright (c) 2015年 赵鹏. All rights reserved.
//

#import "ZPBroCollectionViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
@interface ZPBroCollectionViewCell()
@property (weak, nonatomic) IBOutlet UIImageView *cellImage;

@end
@implementation ZPBroCollectionViewCell

- (void)setImgUrlString:(NSString *)imgUrlString
{
    _imgUrlString = imgUrlString;
    NSURL *url = [NSURL URLWithString:imgUrlString];
    [self.cellImage sd_setImageWithURL:url];
}

@end
