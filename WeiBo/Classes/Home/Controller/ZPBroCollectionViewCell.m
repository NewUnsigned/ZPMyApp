//
//  ZPBroCollectionViewCell.m
//  WeiBo
//
//  Created by 赵鹏 on 15/4/16.
//  Copyright (c) 2015年 赵鹏. All rights reserved.
//

#import "ZPBroCollectionViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
@interface ZPBroCollectionViewCell() <UIScrollViewDelegate>
@property (weak, nonatomic) UIImageView *cellImage;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (nonatomic, assign) CGRect screenFrame;
@end

@implementation ZPBroCollectionViewCell
- (void)awakeFromNib
{
    _screenFrame = [UIScreen mainScreen].bounds;
    self.scrollView.maximumZoomScale = 2;
    self.scrollView.minimumZoomScale = 0.2;
    [self.scrollView setZoomScale:0.2];
}

- (void)setImgUrlString:(NSString *)imgUrlString
{
    _imgUrlString = imgUrlString;
    NSURL *url = [NSURL URLWithString:imgUrlString];
    [self.cellImage sd_setImageWithURL:url];
    CGFloat cellX = _screenFrame.size.width * 0.5;
    CGFloat cellY = _screenFrame.size.height * 0.5;
    [self.cellImage sizeToFit];
    self.cellImage.center =  CGPointMake(cellX,cellY);
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.cellImage;
}
//缩放结束后将图片居中
- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale
{
    CGFloat cellX = _screenFrame.size.width * 0.5;
    CGFloat cellY = _screenFrame.size.height * 0.5;
    [UIView animateWithDuration:0.25 animations:^{
        
        self.cellImage.center =  CGPointMake(cellX,cellY);
    }];
}

@end
