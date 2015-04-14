//
//  ZPPictureCollectionViewCell.m
//  WeiBo
//
//  Created by 赵鹏 on 15/4/13.
//  Copyright (c) 2015年 赵鹏. All rights reserved.
//

#import "ZPPictureCollectionViewCell.h"
#import <UIImageView+WebCache.h>
@interface ZPPictureCollectionViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *picImage;
@end
@implementation ZPPictureCollectionViewCell

- (void)setPicImageName:(NSString *)picImageName
{
    _picImageName = picImageName;
    NSURL *url = [NSURL URLWithString:picImageName];
    [self.picImage sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"00"]];
    
}

@end
