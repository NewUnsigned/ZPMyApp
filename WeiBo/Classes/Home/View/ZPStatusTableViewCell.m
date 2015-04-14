//
//  ZPStatusTableViewCell.m
//  WeiBo
//
//  Created by 赵鹏 on 15/4/13.
//  Copyright (c) 2015年 赵鹏. All rights reserved.
//

#import "ZPStatusTableViewCell.h"
#import <UIImageView+WebCache.h>
#import "ZPStatus.h"
#import "ZPUser.h"
#import "ZPPhoto.h"
#import "UIView+Extension.h"
#import "ZPPictureCollectionViewCell.h"
@interface ZPStatusTableViewCell () <UICollectionViewDelegate,UICollectionViewDataSource>

@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *colViewFlowLayout;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint         *picViewHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint         *picViewWidth;
@property (weak, nonatomic) IBOutlet UICollectionView           *collectionCell;
@property (weak, nonatomic) IBOutlet UIImageView                *iconImage;
@property (weak, nonatomic) IBOutlet UIImageView                *vipImage;
@property (weak, nonatomic) IBOutlet UILabel                    *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel                    *statueSource;
@property (weak, nonatomic) IBOutlet UILabel                    *statueText;
@property (weak, nonatomic) IBOutlet UILabel                    *timeLabel;
@property (weak, nonatomic) IBOutlet UIView                     *bottomView;
@property (weak, nonatomic) IBOutlet UICollectionView *oringinView;
@property (weak, nonatomic) IBOutlet UILabel *forwardStatue;
@property (nonatomic, strong) NSArray *picArr;
@property (nonatomic,   copy) NSString *picName;
@end

@implementation ZPStatusTableViewCell
- (void)awakeFromNib
{
//    _colViewFlowLayout.minimumLineSpacing = 10;
//    _colViewFlowLayout.minimumInteritemSpacing = 10;
//    _colViewFlowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.statueText.preferredMaxLayoutWidth = [UIScreen mainScreen].bounds.size.width - 20;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.picArr.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ZPPhoto *picname;
    if (self.picArr.count != 0 &&self.picArr != nil ) {
        picname = self.picArr[indexPath.item];
    }
    ZPPictureCollectionViewCell *picCell1 = [collectionView dequeueReusableCellWithReuseIdentifier:@"Picture_Cell" forIndexPath:indexPath];
    picCell1.picImageName = picname.thumbnail_pic;
    return picCell1;
}

- (void)setStatus:(ZPStatus *)status
{
    _status = status;
    NSURL *url = [NSURL URLWithString:status.user.profile_image_url];
    [self.iconImage sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"00"]];
    self.iconImage.layer.cornerRadius = 22;
    self.iconImage.layer.masksToBounds = YES;
    self.nameLabel.text = status.user.name;
    self.statueSource.text = status.source;
    self.statueText.text = status.text;
    self.timeLabel.text = status.created_at;
    self.picArr = status.pic_urls;
    CGSize picViewSize = [self reSetPicViewSize];
    self.picViewHeight.constant = picViewSize.height;
    self.picViewWidth.constant = picViewSize.width;
    
    [self.oringinView reloadData];
}
- (CGSize)reSetPicViewSize
{
    // 1.处理没有配图的情况
    NSUInteger count = self.status.pic_urls.count;
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
//    if (count == 0) {
//        return CGSizeZero;
//    }
//    NSUInteger hang = count/3 + 1;
//    NSInteger lie = 3;
//    
//    if (count == 3) {
//        hang = 1;
//    }
//    if (count == 6) {
//        hang = 2;
//    }
//    if (count == 9) {
//        hang = 3;
//    }
//    lie = count < 3 ? count : 3;
//    
//    CGFloat picW = lie * 90 + (lie - 1) * 10;
//    CGFloat picH = hang * 90 + (hang - 1) * 10;
//    NSLog(@"%ld %f %f",count,picW,picH);
//    return CGSizeMake(picW,picH);
    
}
- (CGFloat)countCellRowHight:(ZPStatus *)status
{
    self.status = status;
    [self layoutIfNeeded];
    return CGRectGetMaxY(self.bottomView.frame);
}
- (NSArray *)picArr
{
    if (_picArr == nil) {
        _picArr = [[NSArray alloc]init];
    }
    return _picArr;
}

@end
